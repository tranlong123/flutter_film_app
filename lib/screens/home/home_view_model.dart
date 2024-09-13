import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view_model.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_state.dart';

class HomeViewModel extends BaseViewModel<HomeState> {
  final Ref ref;
  final TrendingRepository trendingRepository;
  HomeViewModel({
    required this.ref,
    required this.trendingRepository,
  }) : super(const HomeState());

  void initData()  {
    _fetchTrendingDayMovies();
  }

  Future<void> _fetchTrendingDayMovies() async {
    try {
      final response = await trendingRepository.getTrendingMoviesDay(1);
      state = state.copyWith(listOfDay: response.results ?? []);
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      state = state.copyWith(listOfDay: []); // Xử lý lỗi nếu cần
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
