import 'dart:async';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_repository.dart';
import 'package:flutter_mvvm_riverpod/screens/home/components/trending_page_view/trending_page_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrendingPageViewModel extends StateNotifier<TrendingPageState> {
  final Ref ref;
  final TrendingRepository trendingRepository;
  TrendingPageViewModel({
    required this.ref,
    required this.trendingRepository,
  }) : super(const TrendingPageState());

  Future<void> initData() async {
    state = state.copyWith(isLoading: true);
    await Future.wait([_fetchTrendingWeekMovies()]);
    state = state.copyWith(isLoading: false);
  }

  Future<void> _fetchTrendingWeekMovies() async {
    try {
      final response = await trendingRepository.getTrendingMoviesWeek(1);
      final trendingWeekList = response.results?.take(6).toList() ?? [];
      if (trendingWeekList.isNotEmpty) {
        state = state.copyWith(trendingWeekList: trendingWeekList);
      } else {
        state = state.copyWith(trendingWeekList: []);
      }
    } catch (e) {
      state = state.copyWith(trendingWeekList: []); // Xử lý lỗi nếu cần
    }
  }

  void setCurrentPage(int int) {
    state = state.copyWith(currentPage: int);
  }
}
