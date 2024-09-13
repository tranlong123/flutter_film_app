import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view_model.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
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
  }) : super(TrendingListState(time: time));

  Future<void> initData() async {
    await _fetchTrendingMovies();
  }

  Future<void> _fetchTrendingMovies({int? page}) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await trendingRepository.getTrendingMovies(
          page ?? state.page, '7ff74d3989927d3ca53bdc4d16facfe9', state.time);
      List<Movie> trendingList = List.from(state.trendingList);
      trendingList.addAll(response.results ?? []);
      state = state.copyWith(trendingList: trendingList);
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      state = state.copyWith(trendingList: []);
    } finally {
      state = state.copyWith(isLoading: false);
      state = state.copyWith(isLoadingMore: false);
    }
  }

  Future<void> loadMoreMovies() async {
    state = state.copyWith(isLoadingMore: true);
    await Future.delayed(const Duration(seconds: 2));
    int page = state.page + 1;
    state = state.copyWith(page: page);
    _fetchTrendingMovies(page: state.page);
  }

  Future<void> refreshMovies() async {
    state = state.copyWith(page: 1);
    state = state.copyWith(isRefreshing: true);
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(isRefreshing: false);
    _fetchTrendingMovies();
  }

  void showScrollTopButton() {
    state = state.copyWith(showScrollTopButton: true);
  }

  void unShowScrollTopButton() {
    state = state.copyWith(showScrollTopButton: false);
  }
}
