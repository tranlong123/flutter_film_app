import 'package:dio/dio.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie_response/movie_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_trending_client.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class ApiTrendingClient {
  factory ApiTrendingClient(Dio dio, {String baseUrl}) = _ApiTrendingClient;

  @GET("/trending/movie/day")
  Future<MovieResponse> getTrendingMoviesDay({
    @Query("api_key") required String apiKey,
    @Query("page") required int page,
  });

  @GET("/trending/movie/week")
  Future<MovieResponse> getTrendingMoviesWeek({
    @Query("api_key") required String apiKey,
    @Query("page") required int page,
  });
  
  @GET("/trending/movie/{time_window}")
  Future<MovieResponse> getTrendingMovies({
    @Path("time_window") required String timeWindow,
    @Query("api_key") required String apiKey,
    @Query("page") required int page,
  });
}
