import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie_detail/movie_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_screen_state.freezed.dart';

@freezed
class MovieScreenState with _$MovieScreenState {
  const factory MovieScreenState({
    @Default(false) bool isLoading,
    @Default([]) List<Movie> mayBeLike,
    MovieDetail? movieDetail, 
    required int id,
  }) = _MovieScreenState;

  const MovieScreenState._();
}
