import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/components/fun_video_play_helper_mixin.dart';
import 'package:fun_fluter/http/models/fun_detail_entity.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/animated_play_pause.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FunVideoPlayer extends StatelessWidget {
  final FunDetailEntity item;
  final int index;
  final bool isInnerList;
  final FunVideoPlayHelperMixin videoPlayHelper;
  final bool multiplex;

  const FunVideoPlayer(
      {super.key,
      required this.item,
      required this.index,
      required this.isInnerList,
      required this.videoPlayHelper,
      this.multiplex = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.joke?.content ?? "-",
          textAlign: TextAlign.left,
          style:
              TextStyle(color: ColorPalette.instance.firstText, fontSize: 30.w),
        ),
        SizedBox(height: 16.w),
        _video()
      ],
    );
  }

  Widget _video() {
    var key = "video_$index";
    bool autoPlay = videoPlayHelper.needAutoPlay(index) || !isInnerList;
    var aspectRatio = (item.joke?.getTestVideoWidth() ?? 1) *
        1.0 /
        (item.joke?.getTestVideoHeight() ?? 1);
    double displayWidth = 686.w;
    double displayHeight = min(displayWidth / aspectRatio, 686.w);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.w),
      child: Container(
        color: Colors.black,
        width: displayWidth,
        height: displayHeight,
        child: VisibilityDetector(
            key: Key(key),
            onVisibilityChanged: (VisibilityInfo info) {
              if (isInnerList) {
                videoPlayHelper.calculatePendingPlayIndex(
                    index, info.visibleFraction);
              }
            },
            child: Stack(
              children: [
                (autoPlay)
                    ? _videoPlayer(aspectRatio)
                    : const SizedBox.shrink(),
                (!autoPlay)
                    ? GestureDetector(
                        onTap: () {
                          videoPlayHelper.manualPlay(item.joke?.jokesId, index);
                        },
                        child: const Align(
                          alignment: Alignment.center,
                          child: AnimatedPlayPause(
                            color: Colors.white,
                            size: 32,
                            playing: false,
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            )),
      ),
    );
  }

  Widget _videoPlayer(double aspectRatio) {
    videoPlayHelper.initVideoPlayer(
      item.joke?.jokesId,
      item.joke?.getTestVideoUrl(),
      aspectRatio,
      multiplex,
      // skin: const CustomVideoPlayerSkin(), // todo
    );
    return Align(
      alignment: Alignment.center,
      child: Chewie(
        controller: videoPlayHelper.chewieController!,
      ),
    );
  }
}
