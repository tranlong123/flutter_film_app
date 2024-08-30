import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view_model.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_repository.dart';
import 'package:flutter_mvvm_riverpod/screens/trending_list/trending_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrendingListViewModel extends BaseViewModel<TrendingListState> {
  final Ref ref;
  final TrendingRepository trendingRepository;

  TrendingListViewModel({
    required this.ref,
    required this.trendingRepository,
    required String time,
  }) : super(TrendingListState(time: time)); // Sử dụng time để khởi tạo state

  Future<void> initData() async {
    await _fetchTrendingMovies();
  }

  Future<void> _fetchTrendingMovies() async {
    state = state.copyWith(isLoading: true);
    try {
      final response =
          await trendingRepository.getTrendingMovies(state.page, state.time);
      state = state.copyWith(trendingList: response.results);
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      state = state.copyWith(trendingList: []);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void refresh() {
    _fetchTrendingMovies();
  }
}
