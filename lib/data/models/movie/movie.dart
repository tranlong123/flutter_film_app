
  import 'package:freezed_annotation/freezed_annotation.dart';

  part 'movie.freezed.dart';
  part 'movie.g.dart';

  @freezed
  class Movie with _$Movie {
    const factory Movie({
      required bool adult,
      required int id,
      required bool video,
      required String title,
      required String overview,
      required double popularity,
      required String backdropPath,
      required List<int> genreIds,
      required String originalLanguage,
      required String originalTitle,
      required double voteAverage,
      required int voteCount,
      required String releaseDate,
      required String posterPath,
      required String mediaType,
    }) = _Movie;

    factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  }

