import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/search_repository.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/screens/search/search_state.dart';
import 'package:flutter_mvvm_riverpod/screens/search/search_view_model.dart';
import 'package:flutter_mvvm_riverpod/widget/create_movie_list.dart';
import 'package:flutter_mvvm_riverpod/widget/scroll_top_button.dart';
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
  @override
  Future<void> onInitState() async {
    super.onInitState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    viewModel.initData();
  }

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

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  SearchViewModel get viewModel => ref.read(_provider.notifier);
  SearchState get state => ref.watch(_provider);
  @override
  Widget buildBody(BuildContext context) {
    return Stack(children: [
      _buildSearchBar(),
      CreateMovieList(
          movies: state.searchList,
          scrollController: scrollController,
          isLoadingMore: state.isLoadingMore,
          refreshMovies: viewModel.refreshMovies),
      if (state.showScrollTopButton) ScrollTopButton(scrollToTop: scrollToTop)
    ]);
  }

  Widget _buildSearchBar() {
    return SizedBox(
      width: AppDimensions.screenWidth,
      height: AppDimensions.sizedBox80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: AppDimensions.sizedBox11),
              child: Container(
                width: AppDimensions.searchBoxWidth,
                height: AppDimensions.searchBoxheight,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(25)),
                child: TextField(
                  onChanged: (text) {
                    viewModel.searchMovie(query: text);
                  },
                  cursorHeight: AppDimensions.sizedBox16,
                  cursorColor: cursorColor,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AppDimensions.contentPaddingVertical,
                        horizontal: AppDimensions.sizedBox24),
                  ),
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 1.1717,
                    fontSize: AppDimensions.fontSize18,
                    color: textInput,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.sizedBox14),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                width: AppDimensions.sizedBox30,
                height: AppDimensions.sizedBox30,
                child: Image.asset('assets/image/XMLID_29_.png'),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
