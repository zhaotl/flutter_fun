import 'package:fun_fluter/generated/json/base/json_field.dart';
import 'package:fun_fluter/generated/json/fun_comment_entity.g.dart';
import 'dart:convert';
export 'package:fun_fluter/generated/json/fun_comment_entity.g.dart';

@JsonSerializable()
class FunCommentEntity {
  int? count;
  List<FunCommentComments>? comments;

  FunCommentEntity();

  factory FunCommentEntity.fromJson(Map<String, dynamic> json) =>
      $FunCommentEntityFromJson(json);

  Map<String, dynamic> toJson() => $FunCommentEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class FunCommentComments {
  int? commentId;
  int? jokeId;
  String? content;
  int? jokeOwnerUserId;
  FunCommentCommentsUser? commentUser;
  int? likeNum;
  int? itemCommentNum;
  String? timeStr;
  bool? isLike;
  dynamic itemCommentList;

  /// 0或者null:收起，1：加载中，2：展开一半， 3：完全展开
  int? status;

  FunCommentComments();

  factory FunCommentComments.fromJson(Map<String, dynamic> json) =>
      $FunCommentCommentsFromJson(json);

  Map<String, dynamic> toJson() => $FunCommentCommentsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class FunCommentCommentsUser {
  int? userId;
  String? userAvatar;
  String? nickname;

  FunCommentCommentsUser();

  factory FunCommentCommentsUser.fromJson(Map<String, dynamic> json) =>
      $FunCommentCommentsUserFromJson(json);

  Map<String, dynamic> toJson() => $FunCommentCommentsUserToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
