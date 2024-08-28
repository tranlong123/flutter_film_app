import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view_model.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_day_repository.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_week_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_state.dart';

class HomeViewModel extends BaseViewModel<HomeState> {
  final Ref ref;
  final TrendingWeekRepository trendingWeekRepository;
  final TrendingDayRepository trendingDayRepository;
  HomeViewModel({
    required this.ref,
    required this.trendingWeekRepository,
    required this.trendingDayRepository,
  }) : super(const HomeState());

  Future<void> initData() async {
    await Future.wait([_fetchTrendingWeekMovies(), _fetchTrendingDayMovies()]);
  }

  Future<void> _fetchTrendingWeekMovies() async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await trendingWeekRepository.getTrendingMovies(1);
      state = state.copyWith(trendingWeekList: response.results);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      state = state.copyWith(trendingWeekList: []); // Xử lý lỗi nếu cần
    }
  }

  Future<void> _fetchTrendingDayMovies() async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await trendingDayRepository.getTrendingMovies(1);
      state = state.copyWith(listOfDay: response.results);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      state = state.copyWith(listOfDay: []); // Xử lý lỗi nếu cần
    }
  }

  void refresh() {
    _fetchTrendingWeekMovies();
    _fetchTrendingDayMovies();
  }
}
