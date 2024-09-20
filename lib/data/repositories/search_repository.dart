import 'package:flutter_mvvm_riverpod/data/models/movie_response/movie_response.dart';
import 'package:flutter_mvvm_riverpod/data/providers/api_client_providers.dart';
import 'package:flutter_mvvm_riverpod/data/services/api/client/api_client.dart';
import 'package:flutter_mvvm_riverpod/resources/key.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final moviesApi = ref.read(apiClientProvider);
  return SearchRepository(moviesApi);
});

class SearchRepository {
  final ApiClient _moviesApi;
  final String _apikey = apikey;
  SearchRepository(this._moviesApi);

  Future<MovieResponse> getSearchMovie(int page, String query) async {
    return await _moviesApi.getSearchMovie(
      apiKey: _apikey,
      page: page, 
      query: query,
    );
  }
}
