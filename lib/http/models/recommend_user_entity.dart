import 'package:fun_fluter/generated/json/base/json_field.dart';
import 'package:fun_fluter/generated/json/recommend_user_entity.g.dart';
import 'dart:convert';
export 'package:fun_fluter/generated/json/recommend_user_entity.g.dart';

@JsonSerializable()
class RecommendUserEntity {
	int? userId;
	String? nickname;
	String? avatar;
	String? fansNum;
	String? jokesNum;
	bool? isAttention;

	RecommendUserEntity();

	factory RecommendUserEntity.fromJson(Map<String, dynamic> json) => $RecommendUserEntityFromJson(json);

	Map<String, dynamic> toJson() => $RecommendUserEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}