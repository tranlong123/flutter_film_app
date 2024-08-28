import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view_model.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_week_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_state.dart';

class HomeViewModel extends BaseViewModel<HomeState> {
  final Ref ref;
  final TrendingWeekRepository trendingWeekRepository;
  HomeViewModel({
    required this.ref,
    required this.trendingWeekRepository,
  }) : super(const HomeState());

  Future<void> initData() async {
    await Future.wait([
      _fetchTrendingMovies(),
    ]);
  }

  Future<void> _fetchTrendingMovies() async {
    try {
      debugPrint('Fetching movies...');
      final response = await trendingWeekRepository.getTrendingMovies(1);
      debugPrint('Fetched movies: ${response.results}');
      state = state.copyWith(trendingWeekList: response.results);
      debugPrint('state movies: ${state.trendingWeekList}');
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      state = state.copyWith(trendingWeekList: []); // Xử lý lỗi nếu cần
    }
  }

  void refresh() {
    _fetchTrendingMovies();
  }
}
