import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie_response/movie_response.dart';
import 'package:flutter_mvvm_riverpod/data/providers/api_client_providers.dart';
import 'package:flutter_mvvm_riverpod/data/services/api/client/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trendingRepositoryProvider = Provider<TrendingRepository>((ref) {
  final moviesApi = ref.read(apiClientProvider);
  return TrendingRepository(moviesApi);
});

class TrendingRepository {
  final ApiClient _moviesApi;
  final String _apikey = dotenv.env['API_KEY']!;
  TrendingRepository(this._moviesApi);

  Future<MovieResponse> getTrendingMoviesDay(int page) async {
    return await _moviesApi.getTrendingMoviesDay(
      apiKey: _apikey,
      page: page,
    );
  }

  Future<MovieResponse> getTrendingMoviesWeek(int page) async {
    return await _moviesApi.getTrendingMoviesWeek(
      apiKey: _apikey,
      page: page,
    );
  }

  Future<MovieResponse> getTrendingMovies(
      int page, String timeWindow) async {
    return await _moviesApi.getTrendingMovies(
      apiKey: _apikey,
      page: page,
      timeWindow: timeWindow,
    );
  }
}
