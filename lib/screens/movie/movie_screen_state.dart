import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie_detail/movie_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_screen_state.freezed.dart';

@freezed
class MovieScreenState with _$MovieScreenState {
  const factory MovieScreenState({
    @Default(false) bool isLoading,
    @Default([]) List<Movie> mayBeLike,
    @Default(
      MovieDetail(
          adult: false,
          backdropPath: 'backdropPath',
          budget: 0,
          genres: [],
          id: 0,
          originalLanguage: 'originalLanguage',
          originalTitle: 'originalTitle',
          overview: 'overview',
          popularity: 0,
          posterPath: 'posterPath',
          releaseDate: 'releaseDate',
          revenue: 0,
          runtime: 0,
          status: 'status',
          tagline: 'tagline',
          title: 'title',
          video: false,
          voteAverage: 0,
          voteCount: 0),
    )
    MovieDetail movieDetail,
    required int id,
  }) = _MovieScreenState;

  const MovieScreenState._();
}
