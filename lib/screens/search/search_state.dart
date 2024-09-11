import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default(1) int page,
    @Default([]) List<Movie> trendingList,
    @Default('') String query,
    @Default(false) isSearching,
    @Default(false) isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isRefreshing,
    @Default(false) bool showScrollTopButton,
  }) = _SearchState;

  const SearchState._();
}
