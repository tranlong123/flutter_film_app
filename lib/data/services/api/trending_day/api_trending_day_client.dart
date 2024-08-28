import 'package:dio/dio.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie_response/movie_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_trending_day_client.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class ApiTrendingDayClient {
  factory ApiTrendingDayClient(Dio dio, {String baseUrl}) = _ApiTrendingDayClient;

  @GET("/trending/movie/day")
  Future<MovieResponse> getTrendingMovies({
    @Query("api_key") required String apiKey,
    @Query("page") required int page,
  });
}