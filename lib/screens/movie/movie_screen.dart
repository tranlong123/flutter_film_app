import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/movie_repository.dart';
import 'package:flutter_mvvm_riverpod/screens/movie/movie_screen_state.dart';
import 'package:flutter_mvvm_riverpod/screens/movie/movie_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _provider =
    StateNotifierProvider.family<MovieViewModel, MovieScreenState, int>(
  (ref, id) => MovieViewModel(
    ref: ref,
    movieRepository: ref.watch(movieRepositoryProvider),
    id: id,
  ),
);

class MovieScreen extends BaseView {
  final int id;
  const MovieScreen({super.key, required this.id});

  @override
  BaseViewState<MovieScreen, MovieViewModel> createState() =>
      _MovieScreenState();
}

class _MovieScreenState extends BaseViewState<MovieScreen, MovieViewModel> {
  @override
  Future<void> onInitState() async {
    super.onInitState();
    await Future.delayed(Duration.zero, () async {
      await viewModel.initData();
    });
  }

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            '${state.id}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  MovieViewModel get viewModel => ref.read(_provider(widget.id).notifier);
  MovieScreenState get state => ref.watch(_provider(widget.id));
}
