import 'package:fun_fluter/generated/json/base/json_convert_content.dart';
import 'package:fun_fluter/http/models/recommend_user_entity.dart';

RecommendUserEntity $RecommendUserEntityFromJson(Map<String, dynamic> json) {
  final RecommendUserEntity recommendUserEntity = RecommendUserEntity();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    recommendUserEntity.userId = userId;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    recommendUserEntity.nickname = nickname;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    recommendUserEntity.avatar = avatar;
  }
  final String? fansNum = jsonConvert.convert<String>(json['fansNum']);
  if (fansNum != null) {
    recommendUserEntity.fansNum = fansNum;
  }
  final String? jokesNum = jsonConvert.convert<String>(json['jokesNum']);
  if (jokesNum != null) {
    recommendUserEntity.jokesNum = jokesNum;
  }
  final bool? isAttention = jsonConvert.convert<bool>(json['isAttention']);
  if (isAttention != null) {
    recommendUserEntity.isAttention = isAttention;
  }
  return recommendUserEntity;
}

Map<String, dynamic> $RecommendUserEntityToJson(RecommendUserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['nickname'] = entity.nickname;
  data['avatar'] = entity.avatar;
  data['fansNum'] = entity.fansNum;
  data['jokesNum'] = entity.jokesNum;
  data['isAttention'] = entity.isAttention;
  return data;
}

extension RecommendUserEntityExtension on RecommendUserEntity {
  RecommendUserEntity copyWith({
    int? userId,
    String? nickname,
    String? avatar,
    String? fansNum,
    String? jokesNum,
    bool? isAttention,
  }) {
    return RecommendUserEntity()
      ..userId = userId ?? this.userId
      ..nickname = nickname ?? this.nickname
      ..avatar = avatar ?? this.avatar
      ..fansNum = fansNum ?? this.fansNum
      ..jokesNum = jokesNum ?? this.jokesNum
      ..isAttention = isAttention ?? this.isAttention;
  }
}