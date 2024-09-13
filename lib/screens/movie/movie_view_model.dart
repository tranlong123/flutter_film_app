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

  Future<void> _fetchInitData() async {
    movieRepository
        .getMovieDetail(state.id, '7ff74d3989927d3ca53bdc4d16facfe9')
        .then((movieDetail) {
      // Nếu movieDetail có collection
      if (movieDetail.belongsToCollection != null) {
        return movieRepository
            .getMovieColection(movieDetail.belongsToCollection!.id,
                '7ff74d3989927d3ca53bdc4d16facfe9')
            .then((collectionResponse) {
          // Cập nhật state với cả movieDetail và collection
          state = state.copyWith(
            movieDetail: movieDetail,
            mayBeLike: collectionResponse.parts,
            isLoading: false,
          );
        });
      } else {
        // Nếu không có collection, chỉ cập nhật movieDetail
        state = state.copyWith(
          movieDetail: movieDetail,
          isLoading: false,
        );
      }
    }).catchError((e, stacktrace) {
      debugPrint('Error fetching movie detail or collection: $e');
      debugPrint('Stacktrace: $stacktrace');
      state = state.copyWith(isLoading: false);
    });
  }
}
