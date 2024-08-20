// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  factory Movie({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'vote_count') int? voteCount,
    @Default(false) bool video,
    @JsonKey(name: 'vote_average') double? voteAverage,
    double? popularity,
    @JsonKey(name: 'poster_path') required String posterPath,
    @JsonKey(name: 'media_type') required String mediaType,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_title') String? originalTitle,
    @JsonKey(name: 'genre_ids') List<int>? genreIds,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @Default(false) bool adult,
    String? overview,
    @JsonKey(name: 'release_date') String? releaseDate,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
