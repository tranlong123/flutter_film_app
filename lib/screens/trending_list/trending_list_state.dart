import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'trending_list_state.freezed.dart';

@freezed
class TrendingListState with _$TrendingListState {
  const factory TrendingListState({
    @Default(1) int page,
    @Default('week') String time,
    @Default([]) List<Movie> trendingList,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isRefreshing,
    @Default(false) bool showScrollTopButton,
  }) = _TrendingListState;

  const TrendingListState._();
}
