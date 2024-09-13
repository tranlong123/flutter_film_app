import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'trending_page_state.freezed.dart';

@freezed
class TrendingPageState with _$TrendingPageState {
  const factory TrendingPageState({
    @Default([]) List<Movie> trendingWeekList,
    @Default(false) bool isLoading,
    @Default(1) int currentPage,
    @Default([]) List<Movie> trendingWeekListCopy,
  }) = _TrendingPageState;

  const TrendingPageState._();
}
