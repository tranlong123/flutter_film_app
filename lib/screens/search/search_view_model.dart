import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view_model.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/search_repository.dart';
import 'package:flutter_mvvm_riverpod/screens/search/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchViewModel extends BaseViewModel<SearchState> {
  final Ref ref;
  final SearchRepository searchRepository;

  SearchViewModel({required this.ref, required this.searchRepository})
      : super(const SearchState());
  Future<void> initData() async {
    await _fetchSearchMovie();
  }

  Future<void> _fetchSearchMovie({String? query, int? page}) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await searchRepository.getSearchMovie(
          page ?? state.page, query ?? state.query);
      debugPrint('$response');
      List<Movie> searchList = List.from(state.searchList);
      searchList.addAll(response.results ?? []);
      state = state.copyWith(searchList: searchList);
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      state = state.copyWith(searchList: []);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void showScrollTopButton() {
    state = state.copyWith(showScrollTopButton: true);
  }

  Future<void> searchMovie({required String query}) async {
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(query: query, page: 1, searchList: []);
    await _fetchSearchMovie(page: state.page);
  }

  void unShowScrollTopButton() {
    state = state.copyWith(showScrollTopButton: false);
  }

  Future<void> loadMoreMovies() async {
    state = state.copyWith(isLoadingMore: true);
    await Future.delayed(const Duration(seconds: 2));
    int page = state.page + 1;
    state = state.copyWith(page: page);
    _fetchSearchMovie(page: state.page);
    state = state.copyWith(isLoadingMore: false);
  }

  Future<void> refreshMovies() async {
    state = state.copyWith(page: 1, searchList: [], isRefreshing: true);
    await Future.delayed(const Duration(seconds: 1));
    _fetchSearchMovie();
    state = state.copyWith(isRefreshing: false);
  }
}
