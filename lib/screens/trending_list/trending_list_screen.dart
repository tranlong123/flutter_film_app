import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_repository.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: AppDimensions.sizedBox22),
          // Component hiển thị danh sách phim thịnh hành
          CreateTrendingList(movies: state.trendingList),
          SizedBox(height: AppDimensions.sizedBox45),
        ],
      ),
    );
  }

  @override
  TrendingListViewModel get viewModel => ref.read(_provider(widget.time).notifier);
  TrendingListState get state => ref.watch(_provider(widget.time));
}
