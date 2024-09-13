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

  Future<void> initData() async {
    await _fetchMovies();
    state = state.copyWith(isLoading: false);
  }

  Future<void> _fetchMovies() {
    state = state.copyWith(isLoading: true);
    final weekMoviesFuture = trendingRepository.getTrendingMoviesWeek(
        1);
    final dayMoviesFuture = trendingRepository.getTrendingMoviesDay(
        1);

    return Future.wait([weekMoviesFuture, dayMoviesFuture]).then((results) {
      final trendingWeekResponse = results[0];
      final trendingDayResponse = results[1];

      state = state.copyWith(
        trendingWeekList: trendingWeekResponse.results ?? [],
        listOfDay: trendingDayResponse.results ?? [],
      );
    }).catchError((e) {
      debugPrint('Error fetching movies: $e');
      state = state.copyWith(
        trendingWeekList: [],
        listOfDay: [],
      );
    });
  }
}
