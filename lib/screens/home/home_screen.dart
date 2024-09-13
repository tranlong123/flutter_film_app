import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_repository.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/screens/home/components/create_home_top.dart';
import 'package:flutter_mvvm_riverpod/screens/home/components/create_list_of_day.dart';
import 'package:flutter_mvvm_riverpod/screens/home/components/create_trending_page.dart';
import 'package:flutter_mvvm_riverpod/screens/home/home_state.dart';
import 'package:flutter_mvvm_riverpod/screens/home/home_view_model.dart';
import 'package:flutter_mvvm_riverpod/screens/trending_list/trending_list_screen.dart';
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
  Future<void> onInitState() async {
    super.onInitState();
    viewModel.initData();
  }

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppDimensions.sizedBox22),
          const CreateHomeTop(),
          SizedBox(height: AppDimensions.sizedBox14),
          CreateTrendingPage(
            trendingWeekList: state.trendingWeekList.take(6).toList(),
            isLoading: state.isLoading,
          ),
          SizedBox(height: AppDimensions.sizedBox9),
          _buildListOfDayText(context),
          CreateListOfDay(movies: state.listOfDay.take(10).toList()),
          SizedBox(height: AppDimensions.sizedBox45),
        ],
      ),
    );
  }

  Widget _buildListOfDayText(context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TrendingListScreen(time: 'day'),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: AppDimensions.sizedBox16, bottom: AppDimensions.sizedBox9),
        child: Text(
          'List Of Day',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: AppDimensions.fontSize20,
            fontWeight: FontWeight.w700,
            height: 23.44 / 20, // line-height / font-size
            color: black,
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel get viewModel => ref.read(_provider.notifier);
  HomeState get state => ref.watch(_provider);
}
