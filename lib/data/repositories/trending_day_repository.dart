import 'package:flutter_mvvm_riverpod/data/models/movie_response/movie_response.dart';
import 'package:flutter_mvvm_riverpod/data/providers/trending_day_providers.dart';
import 'package:flutter_mvvm_riverpod/data/services/api/trending_day/api_trending_day_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trendingDayRepositoryProvider = Provider<TrendingDayRepository>((ref) {
  final movieApi = ref.read(apiTrendingDayClientProvider);
  return TrendingDayRepository(movieApi);
});

class TrendingDayRepository {
  final ApiTrendingDayClient _movieApi;

  TrendingDayRepository(this._movieApi);

  Future<MovieResponse> getTrendingMovies(int page) async {
    return await _movieApi.getTrendingMovies(apiKey: '7ff74d3989927d3ca53bdc4d16facfe9', page:page);
  }
}