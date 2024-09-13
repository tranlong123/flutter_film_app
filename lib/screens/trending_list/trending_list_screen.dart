import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_repository.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/widget/create_movie_list.dart';
import 'package:flutter_mvvm_riverpod/screens/trending_list/trending_list_state.dart';
import 'package:flutter_mvvm_riverpod/screens/trending_list/trending_list_view_model.dart';
import 'package:flutter_mvvm_riverpod/widget/scroll_top_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _provider = StateNotifierProvider.autoDispose
    .family<TrendingListViewModel, TrendingListState, String>(
  (ref, time) => TrendingListViewModel(
    ref: ref,
    trendingRepository: ref.watch(trendingRepositoryProvider),
    time: time,
  ),
);

class TrendingListScreen extends BaseView {
  final String time;

  const TrendingListScreen({super.key, required this.time});

  @override
  BaseViewState<TrendingListScreen, TrendingListViewModel> createState() =>
      _TrendingListScreenState();
}

class _TrendingListScreenState
    extends BaseViewState<TrendingListScreen, TrendingListViewModel> {
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
  Widget buildBody(BuildContext context) {
    return Stack(children: [
      _buildTitle(),
      CreateMovieList(
          movies: state.trendingList,
          scrollController: scrollController,
          isLoadingMore: state.isLoadingMore,
          refreshMovies: viewModel.refreshMovies),
      if (state.showScrollTopButton) ScrollTopButton(scrollToTop: scrollToTop)
    ]);
  }

  Widget _buildTitle() {
    return SizedBox(
      width: AppDimensions.screenWidth,
      height: AppDimensions.sizedBox80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: AppDimensions.sizedBox20),
            child: Text(
              'Trending',
              style: TextStyle(
                  fontSize: AppDimensions.fontSize30,
                  fontWeight: FontWeight.w700,
                  height: AppDimensions.lineHeight),
            ),
          ),
        ],
      ),
    );
  }

  @override
  TrendingListViewModel get viewModel =>
      ref.read(_provider(widget.time).notifier);
  TrendingListState get state => ref.watch(_provider(widget.time));

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
