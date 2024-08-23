import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';

class MovieResponse {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  MovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Movie> resultsList = list.map((i) => Movie.fromJson(i)).toList();

    return MovieResponse(
      page: json['page'],
      results: resultsList,
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
