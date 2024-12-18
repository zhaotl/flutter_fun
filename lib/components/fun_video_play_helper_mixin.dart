import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:fun_fluter/event/app_lifecycle_change_event.dart';
import 'package:fun_fluter/event/event_bus_manager.dart';
import 'package:fun_fluter/event/home_tab_changed_event.dart';
import 'package:fun_fluter/event/index_nav_changed_event.dart';
import 'package:fun_fluter/http/models/fun_detail_entity.dart';
import 'package:fun_fluter/page/home/home_controller.dart';
import 'package:fun_fluter/page/index/index_controller.dart';
import 'package:fun_fluter/router/routers.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

abstract mixin class FunVideoPlayHelperMixin {
  // 视频播放器
  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;

  int indexPageIndex = 0;
  int homePageIndex = 0;

  int? _jokeId;
  // 当前视频是否处于活跃状态（当前视频所在页面是否正显示在屏幕上）
  bool _isVideoActive = false;

  // 标记app是否退到后台
  bool _appResuming = true;

  // 当前视频列表所有已经完全显示的视频item的index集合
  final List<int> _allDisplayVideoIndexes = [];

  // 当前视频列表第一个完全显示的视频item的index
  int _firstAllDisplayIndex = -1;

  // 当前列表是否在滑动中，滑动介绍后将延迟100ms后播放以一个完全显示的视频item
  bool _isScrolling = false;

  // 当前播放的视频在列表中的索引，由curPlayIndex来驱动视频播放
  final RxInt _curPlayIndex = (-1).obs;

  // 延时播放timer
  Timer? _delayTimer;

  late StreamSubscription _indexPageIndexSubscription;
  late StreamSubscription _homePageIndexSubscription;
  late StreamSubscription _lifecycleStateSubscription;

  bool checkVideoActive();

  bool needAutoPlay(int index) => _curPlayIndex.value == index;

  void manualPlay(int? funId, int index) {
    _jokeId = funId;
    _curPlayIndex.value = index;
  }

  void monitorVideoActive() {
    ever(AppRoutes.curPage, (value) {
      _controlPlayStatus();
    });

    _indexPageIndexSubscription =
        eventBus.on<IndexNavChangedEvent>().listen((event) {
      indexPageIndex = event.index;
      _controlPlayStatus();
    });

    _homePageIndexSubscription =
        eventBus.on<HomeTabChangedEvent>().listen((event) {
      homePageIndex = event.index;
      _controlPlayStatus();
    });

    _lifecycleStateSubscription =
        eventBus.on<AppLifecycleChangeEvent>().listen((event) {
      _appResuming = event.state == AppLifecycleState.resumed;
      _controlPlayStatus();
    });

    indexPageIndex = Get.find<IndexController>().index.value;
    homePageIndex = Get.find<HomeController>().index.value;
    _controlPlayStatus();
  }

  void initVideoPlayer(
      int? jokeId, String? testVideoId, double aspectRatio, bool multiplex,
      {Widget? skin}) {
    if (!_isVideoActive) {
      return;
    }
    if (chewieController?.isFullScreen == true) {
      return;
    }

    /// 段子id的视频，直接复用
    if (jokeId == _jokeId && multiplex) {
      return;
    }
    videoPlayerController?.dispose();
    chewieController?.dispose();
    _jokeId = jokeId;
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(testVideoId ?? ""));

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      showControlsOnInitialize: false,
      autoPlay: true,
      looping: true,
      useRootNavigator: true,
      aspectRatio: aspectRatio,
    );
    // 自定义播放布局
    // customControls: skin); // todo
  }

  void calculatePendingPlayIndex(int index, double visibleFraction) {
    if (!_isVideoActive) {
      return;
    }
    if (chewieController?.isFullScreen == true) {
      return;
    }
    if (visibleFraction == 1) {
      if (!_allDisplayVideoIndexes.contains(index)) {
        _allDisplayVideoIndexes.add(index);
      }
    } else {
      _allDisplayVideoIndexes.remove(index);
    }
    _allDisplayVideoIndexes.sort((a, b) => a.compareTo(b));
    _firstAllDisplayIndex = _allDisplayVideoIndexes.firstOrNull ?? -1;
    if (!_isScrolling) {
      _updatePlayIndex();
    }
  }

  void scrollNotificationCallback(ScrollNotification notification) {
    if (notification is ScrollStartNotification ||
        notification is ScrollUpdateNotification) {
      _isScrolling = true;
    } else {
      if (_isScrolling) {
        _isScrolling = false;
        _updatePlayIndex();
      }
    }
  }

  void _updatePlayIndex() {
    if (!_isVideoActive) {
      return;
    }

    if (chewieController?.isFullScreen == true) {
      return;
    }

    if (_curPlayIndex.value != _firstAllDisplayIndex &&
        _firstAllDisplayIndex != 1) {
      if (_delayTimer != null && _delayTimer?.isActive == true) {
        _delayTimer?.cancel();
      }
      _delayTimer = Timer(Duration(milliseconds: 100), () {
        _curPlayIndex.value = _firstAllDisplayIndex;
      });
    }
  }

  void resetPlayList() {
    if (!_isVideoActive) {
      return;
    }
    videoPlayerController?.pause();
    _jokeId = null;
    _allDisplayVideoIndexes.clear();
    _firstAllDisplayIndex = -1;
    _curPlayIndex.value = -1;
  }

  void disposePlayer() {
    resetPlayList();
    videoPlayerController?.dispose();
    chewieController?.dispose();
    _indexPageIndexSubscription.cancel();
    _homePageIndexSubscription.cancel();
    _lifecycleStateSubscription.cancel();
  }

  void _controlPlayStatus() {
    /// 处理详情页需要和列表页item共享一个播放器
    bool shareSamePlayerInDetailPage = false;
    if (AppRoutes.curPage.value == AppRoutes.jokeDetailPage) {
      FunDetailEntity? detail = Get.arguments?['jokeDetailEntity'];
      if (detail != null) {
        shareSamePlayerInDetailPage = detail.joke?.jokesId == _jokeId &&
            AppRoutes.curPage.value == AppRoutes.jokeDetailPage;
      }
    }

    _isVideoActive =
        (checkVideoActive() || shareSamePlayerInDetailPage) && _appResuming;

    if (_isVideoActive) {
      _startPlayer();
    } else {
      _pausePlayer();
    }
  }

  void _startPlayer() {
    if (videoPlayerController?.value.isInitialized == true) {
      chewieController?.play();
    }
  }

  void _pausePlayer() {
    if (videoPlayerController?.value.isInitialized == true) {
      chewieController?.pause();
    }
  }
}
