// trending_week_state.dart
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrendingWeekState {
  final AsyncValue<List<Movie>> movies;

  TrendingWeekState({required this.movies});

  TrendingWeekState copyWith({AsyncValue<List<Movie>>? movies}) {
    return TrendingWeekState(movies: movies ?? this.movies);
  }

  factory TrendingWeekState.initial() {
    return TrendingWeekState(movies: const AsyncValue.loading());
  }
}
