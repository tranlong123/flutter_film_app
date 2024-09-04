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
  late ScrollController scrollController;

  TrendingListViewModel({
    required this.ref,
    required this.trendingRepository,
    required String time,
  }) : super(TrendingListState(time: time)) {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  Future<void> _fetchTrendingMovies({int? page}) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await trendingRepository.getTrendingMovies(
          page ?? state.page, state.time);
      if (state.isLoadingMore) {
        List<Movie> trendingList =
            List.from(state.trendingList); // Sao chép danh sách hiện tại
        trendingList
            .addAll(response.results); // Thêm các phần tử từ response.results
        state = state.copyWith(trendingList: trendingList);
      } else {
        state = state.copyWith(trendingList: response.results);
      }
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      state = state.copyWith(trendingList: []);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // scroll
  void _scrollListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !state.isLoadingMore) {
      loadMoreMovies();
    }
    if (scrollController.position.pixels > 0 && !state.showScrollTopButton) {
      state = state.copyWith(showScrollTopButton: true);
    } else if (scrollController.position.pixels <= 0 &&
        state.showScrollTopButton) {
      state = state.copyWith(showScrollTopButton: false);
    }
  }

  Future<void> loadMoreMovies() async {
    // Thêm logic tải thêm phim vào đây
    state = state.copyWith(isLoadingMore: true);
    await Future.delayed(const Duration(seconds: 2));
    int page = state.page + 1;
    state = state.copyWith(page: page);
    _fetchTrendingMovies(page: state.page);
  }

  Future<void> initData() async {
    await _fetchTrendingMovies();
  }

  Future<void> refreshMovies() async {
    state = state.copyWith(page: 1);
    state = state.copyWith(isRefreshing: true);
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(isRefreshing: false);
    _fetchTrendingMovies();
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
