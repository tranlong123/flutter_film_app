import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/search_repository.dart';
import 'package:flutter_mvvm_riverpod/screens/search/search_state.dart';
import 'package:flutter_mvvm_riverpod/screens/search/search_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _provider =
    StateNotifierProvider.autoDispose<SearchViewModel, SearchState>(
  (ref) => SearchViewModel(
    ref: ref,
    searchRepository: ref.watch(searchRepositoryProvider),
  ),
);

class SearchScreen extends BaseView {
  const SearchScreen({super.key});

  @override
  BaseViewState<SearchScreen, SearchViewModel> createState() =>
      _SearchScreenState();
}

class _SearchScreenState extends BaseViewState<SearchScreen, SearchViewModel> {
  late ScrollController scrollController;
  void _scrollListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !state.isLoadingMore) {
      viewModel.loadMoreMovies();
    }
    if (scrollController.position.pixels > 0 && !state.showScrollTopButton) {
      viewModel.showScrollTopButton();
    } else if (scrollController.position.pixels <= 0 &&
        state.showScrollTopButton) {
      viewModel.unShowScrollTopButton();
    }
  }

  @override
  Future<void> onInitState() async {
    super.onInitState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  @override
  SearchViewModel get viewModel => ref.read(_provider.notifier);
  SearchState get state => ref.watch(_provider);
  @override
  Widget buildBody(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
