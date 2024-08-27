import 'dart:async';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_week_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_state.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel({
    required this.ref,
    required this.trendingWeekRepository,
  }) : super(const HomeState());

  final Ref ref;
  final TrendingWeekRepository trendingWeekRepository;

  Future<void> initData() async {
    await Future.wait([
      _fetchTrendingMovies(),
    ]);
  }

  Future<void> _fetchTrendingMovies() async {
    try {
      final response = await trendingWeekRepository.getTrendingMovies(1);
      state = state.copyWith(trendingWeekList: response.results); 
    } catch (e) {
      state = state.copyWith(trendingWeekList: []);  // Xử lý lỗi nếu cần
    }
  }

  void refresh() {
    _fetchTrendingMovies();
  }
}
