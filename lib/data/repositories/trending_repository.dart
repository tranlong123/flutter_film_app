import 'package:flutter_mvvm_riverpod/data/models/movie_response/movie_response.dart';
import 'package:flutter_mvvm_riverpod/data/providers/trending_providers.dart';
import 'package:flutter_mvvm_riverpod/data/services/api/trending/api_trending_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trendingRepositoryProvider = Provider<TrendingRepository>((ref) {
  final movieApi = ref.read(apiTrendingClientProvider);
  return TrendingRepository(movieApi);
});

class TrendingRepository {
  final ApiTrendingClient _movieApi;

  TrendingRepository(this._movieApi);

  Future<MovieResponse> getTrendingMoviesDay(int page) async {
    return await _movieApi.getTrendingMoviesDay(
      apiKey: '7ff74d3989927d3ca53bdc4d16facfe9',
      page: page,
    );
  }

  Future<MovieResponse> getTrendingMoviesWeek(int page) async {
    return await _movieApi.getTrendingMoviesWeek(
      apiKey: '7ff74d3989927d3ca53bdc4d16facfe9',
      page: page,
    );
  }

  Future<MovieResponse> getTrendingMovies(int page, String timeWindow) async {
    return await _movieApi.getTrendingMovies(
      apiKey: '7ff74d3989927d3ca53bdc4d16facfe9',
      page: page,
      timeWindow: timeWindow,
    );
  }
}
