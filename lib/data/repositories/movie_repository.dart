import 'package:flutter_mvvm_riverpod/data/models/movie_colection/movie_colection.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie_detail/movie_detail.dart';
import 'package:flutter_mvvm_riverpod/data/providers/api_client_providers.dart';
import 'package:flutter_mvvm_riverpod/data/services/api/client/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final moviesApi = ref.read(apiClientProvider);
  return MovieRepository(moviesApi);
});

class MovieRepository {
  final ApiClient _moviesApi;
  final String _apikey = '7ff74d3989927d3ca53bdc4d16facfe9';
  MovieRepository(this._moviesApi);

  Future<MovieDetail> getMovieDetail(int id) async {
    return await _moviesApi.getMovieDetail(
      apiKey: _apikey,
      id: id,
    );
  }

  Future<MovieColection> getMovieColection(int id) async {
    return await _moviesApi.getMovieColection(
      apiKey: _apikey,
      id: id,
    );
  }
}
