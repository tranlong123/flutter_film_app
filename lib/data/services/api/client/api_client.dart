import 'package:dio/dio.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie_response/movie_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

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

  @GET("/movie/{id}")
  Future<MovieResponse> getMovieDetail({
    @Path("id") required int id,
    @Query("api_key") required String apiKey,
  });

  @GET("/collection/{id}")
  Future<MovieResponse> getMovieColection({
    @Path("id") required int id,
    @Query("api_key") required String apiKey,
  });
}
