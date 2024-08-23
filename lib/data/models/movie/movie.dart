import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required bool adult,
    required String backdropPath,
    required String overview,
    required List<int> genreIds,
    required String originalLanguage,
    required String originalTitle,
    required int id,
    required bool video,
    required double voteAverage,
    required String title,
    required int voteCount,
    required String releaseDate,
    String? posterPath,  // This should be nullable if it's optional
    required double popularity,
    required String mediaType,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}

