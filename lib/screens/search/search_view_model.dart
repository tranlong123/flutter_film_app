import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view_model.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/search_repository.dart';
import 'package:flutter_mvvm_riverpod/screens/search/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchViewModel extends BaseViewModel<SearchState> {
  final Ref ref;
  final SearchRepository searchRepository;

  SearchViewModel({required this.ref, required this.searchRepository})
      : super(const SearchState());

  Future<void> _fetchSearchMovie({String? query}) async {
    
  }

  void showScrollTopButton() {
    state = state.copyWith(showScrollTopButton: true);
  }

  void unShowScrollTopButton() {
    state = state.copyWith(showScrollTopButton: false);
  }
  Future<void> loadMoreMovies() async {
    // Thêm logic tải thêm phim vào đây
    state = state.copyWith(isLoadingMore: true);
    await Future.delayed(const Duration(seconds: 2));
    int page = state.page + 1;
    state = state.copyWith(page: page);
    _fetchSearchMovie(query: state.query);
  }
}
