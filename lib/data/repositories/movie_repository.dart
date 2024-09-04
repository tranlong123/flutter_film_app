import 'package:flutter_mvvm_riverpod/data/models/movie_response/movie_response.dart';
import 'package:flutter_mvvm_riverpod/data/providers/api_client_providers.dart';
import 'package:flutter_mvvm_riverpod/data/services/api/client/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final moviesApi = ref.read(apiClientProvider);
  return MovieRepository(moviesApi);
});

class MovieRepository {
  final ApiClient _moviesApi;

  MovieRepository(this._moviesApi);

  Future<MovieResponse> getMovieDetail(int id) async {
    return await _moviesApi.getMovieDetail(
      apiKey: '7ff74d3989927d3ca53bdc4d16facfe9',
      id: id,
    );
  }  
  Future<MovieResponse> getMovieColection(int id) async {
    return await _moviesApi.getMovieColection(
      apiKey: '7ff74d3989927d3ca53bdc4d16facfe9',
      id: id,
    );
  }
}
