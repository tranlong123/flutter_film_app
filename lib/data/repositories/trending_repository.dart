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

  Future<MovieResponse> getTrendingMoviesDay(int page) async {
    return await _moviesApi.getTrendingMoviesDay(
      apiKey: '7ff74d3989927d3ca53bdc4d16facfe9',
      page: page,
    );
  }

  Future<MovieResponse> getTrendingMoviesWeek(int page) async {
    return await _moviesApi.getTrendingMoviesWeek(
      apiKey: '7ff74d3989927d3ca53bdc4d16facfe9',
      page: page,
    );
  }

  Future<MovieResponse> getTrendingMovies(int page, String timeWindow) async {
    return await _moviesApi.getTrendingMovies(
      apiKey: '7ff74d3989927d3ca53bdc4d16facfe9',
      page: page,
      timeWindow: timeWindow,
    );
  }
}
