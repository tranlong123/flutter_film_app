import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view_model.dart';
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
  }) : super(MovieScreenState(id: id));

  Future<void> initData() async {
    state = state.copyWith(isLoading: true);
    await _fetchMovieDetail();
  }

  Future<void> _fetchMovieDetail() async {
    try {
      debugPrint('Start fetching movie detail for id: ${state.id}');
      final response = await movieRepository.getMovieDetail(state.id);
      // Kiểm tra xem từng trường trong response có null không
      if (response.backdropPath == null) {
        debugPrint('backdropPath is null');
      }
      if (response.posterPath == null) {
        debugPrint('posterPath is null');
      }
      debugPrint('API Response: $response');
      state = state.copyWith(movieDetail: response);
      debugPrint('State updated with movie detail');
      state = state.copyWith(isLoading: false);
    } catch (e, stacktrace) {
      debugPrint('state id: ${state.id}');
      debugPrint('Error fetching movie detail: $e');
      debugPrint('Stacktrace: $stacktrace');
      state = state.copyWith(isLoading: false);
    }
  }
}
