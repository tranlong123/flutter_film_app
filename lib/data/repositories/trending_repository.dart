import 'package:flutter_mvvm_riverpod/data/models/movie_response/movie_response.dart';
import 'package:flutter_mvvm_riverpod/data/providers/api_client_providers.dart';
import 'package:flutter_mvvm_riverpod/data/services/api/client/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trendingRepositoryProvider = Provider<TrendingRepository>((ref) {
  final moviesApi = ref.read(apiClientProvider);
  return TrendingRepository(moviesApi);
});

class TrendingRepository {
  final ApiClient _moviesApi;
  TrendingRepository(this._moviesApi);

  Future<MovieResponse> getTrendingMoviesDay(int page,String apikey) async {
    return await _moviesApi.getTrendingMoviesDay(
      apiKey: apikey,
      page: page,
    );
  }

  Future<MovieResponse> getTrendingMoviesWeek(int page,String apikey) async {
    return await _moviesApi.getTrendingMoviesWeek(
      apiKey: apikey,
      page: page,
    );
  }

  Future<MovieResponse> getTrendingMovies(int page,String apikey, String timeWindow) async {
    return await _moviesApi.getTrendingMovies(
      apiKey: apikey,
      page: page,
      timeWindow: timeWindow,
    );
  }
}
