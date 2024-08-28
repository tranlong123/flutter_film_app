import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<Movie> trendingWeekList,
    @Default([]) List<Movie> listOfDay,
    @Default(false) bool isLoading,
  }) = _HomeState;

  const HomeState._();
}
