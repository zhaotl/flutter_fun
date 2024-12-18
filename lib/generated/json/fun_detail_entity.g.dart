import 'package:fun_fluter/generated/json/base/json_convert_content.dart';
import 'package:fun_fluter/http/models/fun_detail_entity.dart';

FunDetailEntity $FunDetailEntityFromJson(Map<String, dynamic> json) {
  final FunDetailEntity funDetailEntity = FunDetailEntity();
  final FunDetailEntityJoke? joke = jsonConvert.convert<FunDetailEntityJoke>(
      json['joke']);
  if (joke != null) {
    funDetailEntity.joke = joke;
  }
  final FunDetailEntityInfo? info = jsonConvert.convert<FunDetailEntityInfo>(
      json['info']);
  if (info != null) {
    funDetailEntity.info = info;
  }
  final FunDetailEntityUser? user = jsonConvert.convert<FunDetailEntityUser>(
      json['user']);
  if (user != null) {
    funDetailEntity.user = user;
  }
  return funDetailEntity;
}

Map<String, dynamic> $FunDetailEntityToJson(FunDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['joke'] = entity.joke?.toJson();
  data['info'] = entity.info?.toJson();
  data['user'] = entity.user?.toJson();
  return data;
}

extension FunDetailEntityExtension on FunDetailEntity {
  FunDetailEntity copyWith({
    FunDetailEntityJoke? joke,
    FunDetailEntityInfo? info,
    FunDetailEntityUser? user,
  }) {
    return FunDetailEntity()
      ..joke = joke ?? this.joke
      ..info = info ?? this.info
      ..user = user ?? this.user;
  }
}

FunDetailEntityJoke $FunDetailEntityJokeFromJson(Map<String, dynamic> json) {
  final FunDetailEntityJoke funDetailEntityJoke = FunDetailEntityJoke();
  final int? jokesId = jsonConvert.convert<int>(json['jokesId']);
  if (jokesId != null) {
    funDetailEntityJoke.jokesId = jokesId;
  }
  final String? addTime = jsonConvert.convert<String>(json['addTime']);
  if (addTime != null) {
    funDetailEntityJoke.addTime = addTime;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    funDetailEntityJoke.content = content;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    funDetailEntityJoke.userId = userId;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    funDetailEntityJoke.type = type;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['imageUrl']);
  if (imageUrl != null) {
    funDetailEntityJoke.imageUrl = imageUrl;
  }
  final bool? hot = jsonConvert.convert<bool>(json['hot']);
  if (hot != null) {
    funDetailEntityJoke.hot = hot;
  }
  final dynamic latitudeLongitude = json['latitudeLongitude'];
  if (latitudeLongitude != null) {
    funDetailEntityJoke.latitudeLongitude = latitudeLongitude;
  }
  final String? showAddress = jsonConvert.convert<String>(json['showAddress']);
  if (showAddress != null) {
    funDetailEntityJoke.showAddress = showAddress;
  }
  final String? thumbUrl = jsonConvert.convert<String>(json['thumbUrl']);
  if (thumbUrl != null) {
    funDetailEntityJoke.thumbUrl = thumbUrl;
  }
  final String? videoUrl = jsonConvert.convert<String>(json['videoUrl']);
  if (videoUrl != null) {
    funDetailEntityJoke.videoUrl = videoUrl;
  }
  final int? videoTime = jsonConvert.convert<int>(json['videoTime']);
  if (videoTime != null) {
    funDetailEntityJoke.videoTime = videoTime;
  }
  final dynamic videoSize = json['videoSize'];
  if (videoSize != null) {
    funDetailEntityJoke.videoSize = videoSize;
  }
  final String? imageSize = jsonConvert.convert<String>(json['imageSize']);
  if (imageSize != null) {
    funDetailEntityJoke.imageSize = imageSize;
  }
  final String? auditMsg = jsonConvert.convert<String>(json['audit_msg']);
  if (auditMsg != null) {
    funDetailEntityJoke.auditMsg = auditMsg;
  }
  return funDetailEntityJoke;
}

Map<String, dynamic> $FunDetailEntityJokeToJson(FunDetailEntityJoke entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['jokesId'] = entity.jokesId;
  data['addTime'] = entity.addTime;
  data['content'] = entity.content;
  data['userId'] = entity.userId;
  data['type'] = entity.type;
  data['imageUrl'] = entity.imageUrl;
  data['hot'] = entity.hot;
  data['latitudeLongitude'] = entity.latitudeLongitude;
  data['showAddress'] = entity.showAddress;
  data['thumbUrl'] = entity.thumbUrl;
  data['videoUrl'] = entity.videoUrl;
  data['videoTime'] = entity.videoTime;
  data['videoSize'] = entity.videoSize;
  data['imageSize'] = entity.imageSize;
  data['audit_msg'] = entity.auditMsg;
  return data;
}

extension FunDetailEntityJokeExtension on FunDetailEntityJoke {
  FunDetailEntityJoke copyWith({
    int? jokesId,
    String? addTime,
    String? content,
    int? userId,
    int? type,
    String? imageUrl,
    bool? hot,
    dynamic latitudeLongitude,
    String? showAddress,
    String? thumbUrl,
    String? videoUrl,
    int? videoTime,
    dynamic videoSize,
    String? imageSize,
    String? auditMsg,
  }) {
    return FunDetailEntityJoke()
      ..jokesId = jokesId ?? this.jokesId
      ..addTime = addTime ?? this.addTime
      ..content = content ?? this.content
      ..userId = userId ?? this.userId
      ..type = type ?? this.type
      ..imageUrl = imageUrl ?? this.imageUrl
      ..hot = hot ?? this.hot
      ..latitudeLongitude = latitudeLongitude ?? this.latitudeLongitude
      ..showAddress = showAddress ?? this.showAddress
      ..thumbUrl = thumbUrl ?? this.thumbUrl
      ..videoUrl = videoUrl ?? this.videoUrl
      ..videoTime = videoTime ?? this.videoTime
      ..videoSize = videoSize ?? this.videoSize
      ..imageSize = imageSize ?? this.imageSize
      ..auditMsg = auditMsg ?? this.auditMsg;
  }
}

FunDetailEntityInfo $FunDetailEntityInfoFromJson(Map<String, dynamic> json) {
  final FunDetailEntityInfo funDetailEntityInfo = FunDetailEntityInfo();
  final int? likeNum = jsonConvert.convert<int>(json['likeNum']);
  if (likeNum != null) {
    funDetailEntityInfo.likeNum = likeNum;
  }
  final int? shareNum = jsonConvert.convert<int>(json['shareNum']);
  if (shareNum != null) {
    funDetailEntityInfo.shareNum = shareNum;
  }
  final int? commentNum = jsonConvert.convert<int>(json['commentNum']);
  if (commentNum != null) {
    funDetailEntityInfo.commentNum = commentNum;
  }
  final int? disLikeNum = jsonConvert.convert<int>(json['disLikeNum']);
  if (disLikeNum != null) {
    funDetailEntityInfo.disLikeNum = disLikeNum;
  }
  final bool? isLike = jsonConvert.convert<bool>(json['isLike']);
  if (isLike != null) {
    funDetailEntityInfo.isLike = isLike;
  }
  final bool? isUnlike = jsonConvert.convert<bool>(json['isUnlike']);
  if (isUnlike != null) {
    funDetailEntityInfo.isUnlike = isUnlike;
  }
  final bool? isAttention = jsonConvert.convert<bool>(json['isAttention']);
  if (isAttention != null) {
    funDetailEntityInfo.isAttention = isAttention;
  }
  return funDetailEntityInfo;
}

Map<String, dynamic> $FunDetailEntityInfoToJson(FunDetailEntityInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['likeNum'] = entity.likeNum;
  data['shareNum'] = entity.shareNum;
  data['commentNum'] = entity.commentNum;
  data['disLikeNum'] = entity.disLikeNum;
  data['isLike'] = entity.isLike;
  data['isUnlike'] = entity.isUnlike;
  data['isAttention'] = entity.isAttention;
  return data;
}

extension FunDetailEntityInfoExtension on FunDetailEntityInfo {
  FunDetailEntityInfo copyWith({
    int? likeNum,
    int? shareNum,
    int? commentNum,
    int? disLikeNum,
    bool? isLike,
    bool? isUnlike,
    bool? isAttention,
  }) {
    return FunDetailEntityInfo()
      ..likeNum = likeNum ?? this.likeNum
      ..shareNum = shareNum ?? this.shareNum
      ..commentNum = commentNum ?? this.commentNum
      ..disLikeNum = disLikeNum ?? this.disLikeNum
      ..isLike = isLike ?? this.isLike
      ..isUnlike = isUnlike ?? this.isUnlike
      ..isAttention = isAttention ?? this.isAttention;
  }
}

FunDetailEntityUser $FunDetailEntityUserFromJson(Map<String, dynamic> json) {
  final FunDetailEntityUser funDetailEntityUser = FunDetailEntityUser();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    funDetailEntityUser.userId = userId;
  }
  final String? nickName = jsonConvert.convert<String>(json['nickName']);
  if (nickName != null) {
    funDetailEntityUser.nickName = nickName;
  }
  final String? signature = jsonConvert.convert<String>(json['signature']);
  if (signature != null) {
    funDetailEntityUser.signature = signature;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    funDetailEntityUser.avatar = avatar;
  }
  return funDetailEntityUser;
}

Map<String, dynamic> $FunDetailEntityUserToJson(FunDetailEntityUser entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['nickName'] = entity.nickName;
  data['signature'] = entity.signature;
  data['avatar'] = entity.avatar;
  return data;
}

extension FunDetailEntityUserExtension on FunDetailEntityUser {
  FunDetailEntityUser copyWith({
    int? userId,
    String? nickName,
    String? signature,
    String? avatar,
  }) {
    return FunDetailEntityUser()
      ..userId = userId ?? this.userId
      ..nickName = nickName ?? this.nickName
      ..signature = signature ?? this.signature
      ..avatar = avatar ?? this.avatar;
  }
}