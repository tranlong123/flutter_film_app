import 'package:flutter_mvvm_riverpod/data/models/movie_response/movie_response.dart';
import 'package:flutter_mvvm_riverpod/data/providers/trending_week_providers.dart';
import 'package:flutter_mvvm_riverpod/data/services/api/trending/api_trending_week_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trendingWeekRepositoryProvider = Provider<TrendingWeekRepository>((ref) {
  final movieApi = ref.read(apiTrendingWeekClientProvider);
  return TrendingWeekRepository(movieApi);
});

class TrendingWeekRepository {
  final ApiTrendingWeekClient _movieApi;

  TrendingWeekRepository(this._movieApi);

  Future<MovieResponse> getTrendingMovies(int page) async {
    return await _movieApi.getTrendingMovies(apiKey: '7ff74d3989927d3ca53bdc4d16facfe9', page:page);
  }
}