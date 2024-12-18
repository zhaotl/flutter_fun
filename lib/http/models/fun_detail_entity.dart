import 'package:fun_fluter/generated/json/base/json_field.dart';
import 'package:fun_fluter/generated/json/fun_detail_entity.g.dart';
import 'dart:convert';
export 'package:fun_fluter/generated/json/fun_detail_entity.g.dart';

@JsonSerializable()
class FunDetailEntity {
  FunDetailEntityJoke? joke;
  FunDetailEntityInfo? info;
  FunDetailEntityUser? user;

  FunDetailEntity();

  factory FunDetailEntity.fromJson(Map<String, dynamic> json) =>
      $FunDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $FunDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class FunDetailEntityJoke {
  int? jokesId;
  String? addTime;
  String? content;
  int? userId;
  int? type;
  String? imageUrl;
  bool? hot;
  dynamic latitudeLongitude;
  String? showAddress;
  String? thumbUrl;
  String? videoUrl;
  int? videoTime;
  dynamic videoSize;
  String? imageSize;
  @JSONField(name: "audit_msg")
  String? auditMsg;

  FunDetailEntityJoke();

  factory FunDetailEntityJoke.fromJson(Map<String, dynamic> json) =>
      $FunDetailEntityJokeFromJson(json);

  Map<String, dynamic> toJson() => $FunDetailEntityJokeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class FunDetailEntityInfo {
  int? likeNum;
  int? shareNum;
  int? commentNum;
  int? disLikeNum;
  bool? isLike;
  bool? isUnlike;
  bool? isAttention;

  FunDetailEntityInfo();

  factory FunDetailEntityInfo.fromJson(Map<String, dynamic> json) =>
      $FunDetailEntityInfoFromJson(json);

  Map<String, dynamic> toJson() => $FunDetailEntityInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class FunDetailEntityUser {
  int? userId;
  String? nickName;
  String? signature;
  String? avatar;

  FunDetailEntityUser();

  factory FunDetailEntityUser.fromJson(Map<String, dynamic> json) =>
      $FunDetailEntityUserFromJson(json);

  Map<String, dynamic> toJson() => $FunDetailEntityUserToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
