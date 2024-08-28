import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_day_repository.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_week_repository.dart';
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
    trendingWeekRepository: ref.watch(trendingWeekRepositoryProvider),
    trendingDayRepository: ref.watch(trendingDayRepositoryProvider),
  ),
);

class HomeScreen extends BaseView {
  const HomeScreen({super.key});

  @override
  BaseViewState<HomeScreen, HomeViewModel> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseViewState<HomeScreen, HomeViewModel> {
  @override
  Future<void> onInitState() async {
    super.onInitState();
    await Future.delayed(Duration.zero, () async {
      await viewModel.initData();
    });
  }

  @override
  Widget buildBody(BuildContext context) {
    AppDimensions.init(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: AppDimensions.sizedBox22),
          const CreateHomeTop(),
          SizedBox(height: AppDimensions.sizedBox14),
          CreateTrendingPage(movies: state.trendingWeekList.take(6).toList()),
          SizedBox(height: AppDimensions.sizedBox9),
          CreateListOfDay(movies: state.listOfDay.take(10).toList())
        ],
      ),
    );
  }

  @override
  HomeViewModel get viewModel => ref.read(_provider.notifier);
  HomeState get state => ref.watch(_provider);
}
