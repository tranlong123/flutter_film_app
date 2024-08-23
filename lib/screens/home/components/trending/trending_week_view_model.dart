import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_week_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trendingWeekListProvider = FutureProvider<List<Movie>>((ref) async {
  final movieRepository = ref.read(trendingWeekRepositoryProvider);
  final response = await movieRepository.getTrendingMovies(1);
  return response.results;
});
