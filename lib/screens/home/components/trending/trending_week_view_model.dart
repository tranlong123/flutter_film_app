// trending_week_view_model.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_week_repository.dart';
import 'trending_week_state.dart';

class TrendingWeekViewModel extends StateNotifier<TrendingWeekState> {
  final TrendingWeekRepository _repository;

  TrendingWeekViewModel(this._repository) : super(TrendingWeekState.initial()) {
    _fetchTrendingMovies();
  }

  Future<void> _fetchTrendingMovies() async {
    try {
      final response = await _repository.getTrendingMovies(1);
      state = state.copyWith(movies: AsyncValue.data(response.results));
    } catch (e, stack) {
      state = state.copyWith(movies: AsyncValue.error(e, stack));
    }
  }
  void refresh() {
    _fetchTrendingMovies();
  }
}

final trendingWeekViewModelProvider = StateNotifierProvider<TrendingWeekViewModel, TrendingWeekState>((ref) {
  final repository = ref.read(trendingWeekRepositoryProvider);
  return TrendingWeekViewModel(repository);
});
