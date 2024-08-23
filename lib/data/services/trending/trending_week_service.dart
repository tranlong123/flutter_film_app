import 'package:dio/dio.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/movie/movie_response.dart';
import 'package:retrofit/retrofit.dart';

part 'trending_week_service.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class TrendingWeekService {
  factory TrendingWeekService(Dio dio, {String baseUrl}) = _TrendingWeekService;

  @GET("/trending/movie/week")
  Future<MovieResponse> getTrendingMovies({
    @Query("api_key") required String apiKey,
    @Query("page") int page = 1,
  });
}
