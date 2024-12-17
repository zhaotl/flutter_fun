import 'package:fun_fluter/generated/json/base/json_field.dart';
import 'package:fun_fluter/generated/json/fun_detail_entity_entity.g.dart';
import 'dart:convert';
export 'package:fun_fluter/generated/json/fun_detail_entity_entity.g.dart';

@JsonSerializable()
class FunDetailEntityEntity {
	late FunDetailEntityJoke joke;
	late FunDetailEntityInfo info;
	late FunDetailEntityUser user;

	FunDetailEntityEntity();

	factory FunDetailEntityEntity.fromJson(Map<String, dynamic> json) => $FunDetailEntityEntityFromJson(json);

	Map<String, dynamic> toJson() => $FunDetailEntityEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FunDetailEntityJoke {
	late int jokesId;
	late String addTime;
	late String content;
	late int userId;
	late int type;
	late String imageUrl;
	late bool hot;
	dynamic latitudeLongitude;
	late String showAddress;
	late String thumbUrl;
	late String videoUrl;
	late int videoTime;
	dynamic videoSize;
	late String imageSize;
	@JSONField(name: "audit_msg")
	late String auditMsg;

	FunDetailEntityJoke();

	factory FunDetailEntityJoke.fromJson(Map<String, dynamic> json) => $FunDetailEntityJokeFromJson(json);

	Map<String, dynamic> toJson() => $FunDetailEntityJokeToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FunDetailEntityInfo {
	late int likeNum;
	late int shareNum;
	late int commentNum;
	late int disLikeNum;
	late bool isLike;
	late bool isUnlike;
	late bool isAttention;

	FunDetailEntityInfo();

	factory FunDetailEntityInfo.fromJson(Map<String, dynamic> json) => $FunDetailEntityInfoFromJson(json);

	Map<String, dynamic> toJson() => $FunDetailEntityInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class FunDetailEntityUser {
	late int userId;
	late String nickName;
	late String signature;
	late String avatar;

	FunDetailEntityUser();

	factory FunDetailEntityUser.fromJson(Map<String, dynamic> json) => $FunDetailEntityUserFromJson(json);

	Map<String, dynamic> toJson() => $FunDetailEntityUserToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}