import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required bool adult,
    required bool video,
    required int id,
    required int voteCount,
    required double popularity,
    required double voteAverage,
    List<int>? genreIds,
    required String title,
    required String overview,
    required String originalLanguage,
    required String originalTitle,
    required String releaseDate,
    String? posterPath,
    String? backdropPath,
    String? mediaType,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
