import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_repository.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/screens/trending_list/components/create_trending_list.dart';
import 'package:flutter_mvvm_riverpod/screens/trending_list/trending_list_state.dart';
import 'package:flutter_mvvm_riverpod/screens/trending_list/trending_list_view_model.dart';
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
  @override
  Future<void> onInitState() async {
    super.onInitState();
    await Future.delayed(Duration.zero, () async {
      await viewModel.initData();
    });
  }

  @override
  Widget buildBody(BuildContext context) {
    return Stack(children: [
      _buildTitle(),
      Column(
        children: [
          SizedBox(height: AppDimensions.sizedBox80),
          // Component hiển thị danh sách phim thịnh hành
          Expanded(
            child: RefreshIndicator(
                onRefresh: () => viewModel.refreshMovies(),
                backgroundColor: fullyTransparent,
                child: CreateTrendingList(
                    movies: state.trendingList,
                    scrollController: viewModel.scrollController,
                    isLoadingMore: state.isLoadingMore)),
          ),
        ],
      ),
      if (state.showScrollTopButton)
        _buildScrollTopButton(scrollToTop: viewModel.scrollToTop)
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

  Widget _buildScrollTopButton({required VoidCallback scrollToTop}) {
    return Positioned(
      top: AppDimensions.scrollTopIconTop,
      left: AppDimensions.scrollTopIconLeft,
      child: GestureDetector(
        onTap: scrollToTop,
        child: SizedBox(
          width: AppDimensions.scrollTopIconWidth,
          height: AppDimensions.scrollTopIconHeight,
          child: Image.asset('assets/image/scrollTopIcon.png'),
        ),
      ),
    );
  }

  @override
  TrendingListViewModel get viewModel =>
      ref.read(_provider(widget.time).notifier);
  TrendingListState get state => ref.watch(_provider(widget.time));
}
