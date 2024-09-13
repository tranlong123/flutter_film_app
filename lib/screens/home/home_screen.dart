import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_repository.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/screens/home/components/create_home_top.dart';
import 'package:flutter_mvvm_riverpod/screens/home/components/create_list_of_day.dart';
import 'package:flutter_mvvm_riverpod/screens/home/components/create_trending_page.dart';
import 'package:flutter_mvvm_riverpod/screens/home/home_state.dart';
import 'package:flutter_mvvm_riverpod/screens/home/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _provider = StateNotifierProvider.autoDispose<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(
    ref: ref,
    trendingRepository: ref.watch(trendingRepositoryProvider),
  ),
);

class HomeScreen extends BaseView {
  const HomeScreen({super.key});

  @override
  BaseViewState<HomeScreen, HomeViewModel> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseViewState<HomeScreen, HomeViewModel> {
  @override
  void onInitState() {
    super.onInitState();
    Future.delayed(Duration.zero, () async {
      viewModel.initData();
    });
  }

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: AppDimensions.sizedBox22),
          const CreateHomeTop(),
          SizedBox(height: AppDimensions.sizedBox14),
          CreateTrendingPage(
            trendingWeekList: state.trendingWeekList.take(6).toList(),
            isLoading: state.isLoading,
          ),
          SizedBox(height: AppDimensions.sizedBox9),
          CreateListOfDay(movies: state.listOfDay.take(10).toList()),
          SizedBox(height: AppDimensions.sizedBox45),
        ],
      ),
    );
  }

  @override
  HomeViewModel get viewModel => ref.read(_provider.notifier);
  HomeState get state => ref.watch(_provider);
}
