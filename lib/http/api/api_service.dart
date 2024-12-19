import 'package:dio/dio.dart';
import 'package:fun_fluter/http/models/base_result.dart';
import 'package:fun_fluter/http/models/fun_comment_entity.dart';
import 'package:fun_fluter/http/models/fun_detail_entity.dart';
import 'package:fun_fluter/http/models/recommend_user_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://tools.cretinzp.com/jokes/")
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  // 获取热搜关键词
  @POST('/helper/hot_search')
  @FormUrlEncoded()
  Future<BaseResult<List<String>>> getHotSearch();

  // 搜索段子
  @POST('/home/jokes/search')
  @FormUrlEncoded()
  Future<BaseResult<List<FunDetailEntity>>> searchJokes(
      @Field() String keyword, @Field() page);

  //status:true为点赞 false为取消点赞
  @POST('/jokes/like')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> likeJoke(
      @Field() String id, @Field() String status);

  //status:true为踩 false为取消踩
  @POST('/jokes/unlike')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> unlikeJoke(
      @Field() String id, @Field() String status);

  /// status 1 关注 0 取消关注
  @POST('/user/attention')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> attentionUser(
      @Field() String status, @Field() String userId);

  @POST('/home/recommend')
  @FormUrlEncoded()
  Future<BaseResult<List<FunDetailEntity>>> getRecommendList(
      @Field() String page);

  @POST('/home/latest')
  @FormUrlEncoded()
  Future<BaseResult<List<FunDetailEntity>>> getLatestList(@Field() String page);

  @POST('/home/text')
  @FormUrlEncoded()
  Future<BaseResult<List<FunDetailEntity>>> getTextList(@Field() String page);

  @POST('/home/pic')
  @FormUrlEncoded()
  Future<BaseResult<List<FunDetailEntity>>> getPicList(@Field() String page);

  @POST('/home/attention/list')
  @FormUrlEncoded()
  Future<BaseResult<List<FunDetailEntity>>> getAttentionList(
      @Field() String page);

  @POST('/home/attention/recommend')
  Future<BaseResult<List<RecommendUserEntity>>> getAttentionRecommendList();

  @POST('/jokes/comment/list')
  @FormUrlEncoded()
  Future<BaseResult<FunCommentEntity>> getJokeCommentList(
      @Field() String jokeId, @Field() String page);

  @POST('/jokes/comment/delete')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> deleteJokeComment(@Field() String commentId);

  @POST('/jokes/comment/like')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> likeJokeComment(
      @Field() String commentId, @Field() String status);
}
