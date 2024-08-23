import 'package:dio/dio.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie_response/movie_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_trending_week_client.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class ApiTrendingWeekClient {
  factory ApiTrendingWeekClient(Dio dio, {String baseUrl}) = _ApiTrendingWeekClient;

  @GET("/trending/movie/week")
  Future<MovieResponse> getTrendingMovies({
    @Query("api_key") required String apiKey,
    @Query("page") required int page,
  });
}
