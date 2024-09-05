import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view_model.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie_detail/movie_detail.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/movie_repository.dart';
import 'package:flutter_mvvm_riverpod/screens/movie/movie_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieViewModel extends BaseViewModel<MovieScreenState> {
  final Ref ref;
  final MovieRepository movieRepository;

  MovieViewModel({
    required this.ref,
    required this.movieRepository,
    required int id,
  }) : super(MovieScreenState(
          id: id,
          movieDetail: const MovieDetail(
              adult: false,
              backdropPath: '/backdropPath',
              budget: 0,
              genres: [],
              id: 1,
              originalLanguage: 'originalLanguage',
              originalTitle: 'originalTitle',
              overview: 'overview',
              popularity: 0,
              posterPath: '/posterPath',
              releaseDate: 'releaseDate',
              revenue: 0,
              runtime: 0,
              status: 'status',
              tagline: 'tagline',
              title: 'title',
              video: false,
              voteAverage: 0,
              voteCount: 0),
        ));

  Future<void> initData() async {
    _fetchInitData();
  }

  Future<void> _fetchMovieDetail() async {
    try {
      final response = await movieRepository.getMovieDetail(state.id);
      debugPrint('API Response: $response');
      state = state.copyWith(movieDetail: response);
    } catch (e, stacktrace) {
      debugPrint('Error fetching movie detail: $e');
      debugPrint('Stacktrace: $stacktrace');
    }
  }

  Future<void> _fetchInitData() async {
    await _fetchMovieDetail();
    debugPrint('///////////////////////////////////////////////');
    if (state.movieDetail.belongsToCollection != null) {
      try {
        final response = await movieRepository
            .getMovieColection(state.movieDetail.belongsToCollection!.id);
        debugPrint('movieRepository: $response');
        state = state.copyWith(mayBeLike: response.parts);
      } catch (e, stacktrace) {
        debugPrint('Error fetching movie detail: $e');
        debugPrint('Stacktrace: $stacktrace');
      } finally {
        state = state.copyWith(isLoading: false);
      }
    }
    state = state.copyWith(isLoading: false);
  }
}
