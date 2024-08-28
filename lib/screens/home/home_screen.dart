import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_week_repository.dart';
import 'package:flutter_mvvm_riverpod/screens/home/home_state.dart';
import 'package:flutter_mvvm_riverpod/screens/home/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _provider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(
    ref: ref,
    trendingWeekRepository: ref.watch(trendingWeekRepositoryProvider),
  );
});

class HomeScreen extends BaseView {
  const HomeScreen({super.key});

  @override
  BaseViewState<HomeScreen, HomeViewModel> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseViewState<HomeScreen, HomeViewModel> {
  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          color: Colors.black,
          child: GestureDetector(
            child: const Text('data'),
            onTap: () => {
              // ignore: avoid_print
              print(ref.read(_provider)),
              // ignore: avoid_print
              print('/////////////////'),
              // ignore: avoid_print
              print(state)
            },
          ),
        ),
      ],
    );
  }

  @override
  HomeViewModel get viewModel => ref.read(_provider.notifier);
  HomeState get state => ref.read(_provider);
  @override
  void onInitState() {
    super.onInitState();
    viewModel.initData();
  }

}
