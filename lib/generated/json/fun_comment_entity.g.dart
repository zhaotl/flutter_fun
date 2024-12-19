import 'package:fun_fluter/generated/json/base/json_convert_content.dart';
import 'package:fun_fluter/http/models/fun_comment_entity.dart';

FunCommentEntity $FunCommentEntityFromJson(Map<String, dynamic> json) {
  final FunCommentEntity funCommentEntity = FunCommentEntity();
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    funCommentEntity.count = count;
  }
  final List<FunCommentComments>? comments = (json['comments'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<FunCommentComments>(e) as FunCommentComments)
      .toList();
  if (comments != null) {
    funCommentEntity.comments = comments;
  }
  return funCommentEntity;
}

Map<String, dynamic> $FunCommentEntityToJson(FunCommentEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['count'] = entity.count;
  data['comments'] = entity.comments?.map((v) => v.toJson()).toList();
  return data;
}

extension FunCommentEntityExtension on FunCommentEntity {
  FunCommentEntity copyWith({
    int? count,
    List<FunCommentComments>? comments,
  }) {
    return FunCommentEntity()
      ..count = count ?? this.count
      ..comments = comments ?? this.comments;
  }
}

FunCommentComments $FunCommentCommentsFromJson(Map<String, dynamic> json) {
  final FunCommentComments funCommentComments = FunCommentComments();
  final int? commentId = jsonConvert.convert<int>(json['commentId']);
  if (commentId != null) {
    funCommentComments.commentId = commentId;
  }
  final int? jokeId = jsonConvert.convert<int>(json['jokeId']);
  if (jokeId != null) {
    funCommentComments.jokeId = jokeId;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    funCommentComments.content = content;
  }
  final int? jokeOwnerUserId = jsonConvert.convert<int>(
      json['jokeOwnerUserId']);
  if (jokeOwnerUserId != null) {
    funCommentComments.jokeOwnerUserId = jokeOwnerUserId;
  }
  final FunCommentCommentsUser? commentUser = jsonConvert.convert<
      FunCommentCommentsUser>(json['commentUser']);
  if (commentUser != null) {
    funCommentComments.commentUser = commentUser;
  }
  final int? likeNum = jsonConvert.convert<int>(json['likeNum']);
  if (likeNum != null) {
    funCommentComments.likeNum = likeNum;
  }
  final int? itemCommentNum = jsonConvert.convert<int>(json['itemCommentNum']);
  if (itemCommentNum != null) {
    funCommentComments.itemCommentNum = itemCommentNum;
  }
  final String? timeStr = jsonConvert.convert<String>(json['timeStr']);
  if (timeStr != null) {
    funCommentComments.timeStr = timeStr;
  }
  final bool? isLike = jsonConvert.convert<bool>(json['isLike']);
  if (isLike != null) {
    funCommentComments.isLike = isLike;
  }
  final dynamic itemCommentList = json['itemCommentList'];
  if (itemCommentList != null) {
    funCommentComments.itemCommentList = itemCommentList;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    funCommentComments.status = status;
  }
  return funCommentComments;
}

Map<String, dynamic> $FunCommentCommentsToJson(FunCommentComments entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['commentId'] = entity.commentId;
  data['jokeId'] = entity.jokeId;
  data['content'] = entity.content;
  data['jokeOwnerUserId'] = entity.jokeOwnerUserId;
  data['commentUser'] = entity.commentUser?.toJson();
  data['likeNum'] = entity.likeNum;
  data['itemCommentNum'] = entity.itemCommentNum;
  data['timeStr'] = entity.timeStr;
  data['isLike'] = entity.isLike;
  data['itemCommentList'] = entity.itemCommentList;
  data['status'] = entity.status;
  return data;
}

extension FunCommentCommentsExtension on FunCommentComments {
  FunCommentComments copyWith({
    int? commentId,
    int? jokeId,
    String? content,
    int? jokeOwnerUserId,
    FunCommentCommentsUser? commentUser,
    int? likeNum,
    int? itemCommentNum,
    String? timeStr,
    bool? isLike,
    dynamic itemCommentList,
    int? status,
  }) {
    return FunCommentComments()
      ..commentId = commentId ?? this.commentId
      ..jokeId = jokeId ?? this.jokeId
      ..content = content ?? this.content
      ..jokeOwnerUserId = jokeOwnerUserId ?? this.jokeOwnerUserId
      ..commentUser = commentUser ?? this.commentUser
      ..likeNum = likeNum ?? this.likeNum
      ..itemCommentNum = itemCommentNum ?? this.itemCommentNum
      ..timeStr = timeStr ?? this.timeStr
      ..isLike = isLike ?? this.isLike
      ..itemCommentList = itemCommentList ?? this.itemCommentList
      ..status = status ?? this.status;
  }
}

FunCommentCommentsUser $FunCommentCommentsUserFromJson(
    Map<String, dynamic> json) {
  final FunCommentCommentsUser funCommentCommentsUser = FunCommentCommentsUser();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    funCommentCommentsUser.userId = userId;
  }
  final String? userAvatar = jsonConvert.convert<String>(json['userAvatar']);
  if (userAvatar != null) {
    funCommentCommentsUser.userAvatar = userAvatar;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    funCommentCommentsUser.nickname = nickname;
  }
  return funCommentCommentsUser;
}

Map<String, dynamic> $FunCommentCommentsUserToJson(
    FunCommentCommentsUser entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['userAvatar'] = entity.userAvatar;
  data['nickname'] = entity.nickname;
  return data;
}

extension FunCommentCommentsUserExtension on FunCommentCommentsUser {
  FunCommentCommentsUser copyWith({
    int? userId,
    String? userAvatar,
    String? nickname,
  }) {
    return FunCommentCommentsUser()
      ..userId = userId ?? this.userId
      ..userAvatar = userAvatar ?? this.userAvatar
      ..nickname = nickname ?? this.nickname;
  }
}