import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_colection.freezed.dart';
part 'movie_colection.g.dart';

@freezed
class MovieColection with _$MovieColection {
  const factory MovieColection({
    required int id,
    required String name,
    required String overview,
    required String posterPath,
    required String backdropPath,
    required List<Movie> parts,
  }) = _MovieColection;

  factory MovieColection.fromJson(Map<String, dynamic> json) =>
      _$MovieColectionFromJson(json);
}
