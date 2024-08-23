import 'package:flutter_mvvm_riverpod/data/providers/dio_config.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/movie/movie_response.dart';
import 'package:flutter_mvvm_riverpod/data/services/trending/trending_week_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider cho TrendingWeekService
final trendingWeekServiceProvider = Provider<TrendingWeekService>((ref) {
  final dio = ref.watch(dioProvider);
  return TrendingWeekService(dio);
});

final trendingMoviesProvider = FutureProvider<MovieResponse>((ref) async {
  final service = ref.watch(trendingWeekServiceProvider);
  const apiKey = '7ff74d3989927d3ca53bdc4d16facfe9';
  final response = await service.getTrendingMovies(apiKey: apiKey);
  return response;
});