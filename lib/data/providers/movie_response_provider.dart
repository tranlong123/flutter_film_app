// Provider cho MovieResponse
import 'package:flutter_mvvm_riverpod/data/providers/trending_movies_provider.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/movie/movie_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trendingMoviesProvider = FutureProvider<MovieResponse>((ref) async {
  final service = ref.watch(trendingWeekServiceProvider);
  const apiKey = '7ff74d3989927d3ca53bdc4d16facfe9';
  final response = await service.getTrendingMovies(apiKey: apiKey);
  return response;
});
