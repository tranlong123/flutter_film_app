import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/data/repositories/trending_repository.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/screens/home/components/trending_page_view/trending_page_state.dart';
import 'package:flutter_mvvm_riverpod/screens/home/components/trending_page_view/trending_page_view_model.dart';
import 'package:flutter_mvvm_riverpod/widget/movie_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final _provider =
    StateNotifierProvider.autoDispose<TrendingPageViewModel, TrendingPageState>(
  (ref) => TrendingPageViewModel(
    ref: ref,
    trendingRepository: ref.watch(trendingRepositoryProvider),
  ),
);

class CreateTrendingPage extends ConsumerStatefulWidget {
  const CreateTrendingPage({super.key});

  @override
  ConsumerState<CreateTrendingPage> createState() => _CreateTrendingPageState();
}

class _CreateTrendingPageState extends ConsumerState<CreateTrendingPage> {
  @override
  void initState() {
    super.initState();
    onInitState();
  }

  Future<void> onInitState() async {
    await Future.delayed(Duration.zero, () async {
      await viewModel.initData();
    });
  }

  TrendingPageViewModel get viewModel => ref.read(_provider.notifier);
  TrendingPageState get state => ref.watch(_provider);

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      // Hiển thị widget loading khi đang tải dữ liệu
      return const Center(child: CircularProgressIndicator());
    }
    if (state.trendingWeekList.isEmpty) {
      return const Center(child: Text('Không có dữ liệu'));
    }
    return Column(
      children: [
        SizedBox(
            height: AppDimensions.isCurrentPageHeight,
            child: CarouselSlider.builder(
              itemCount: state.trendingWeekList.length,
              itemBuilder: (context, index, realIndex) {
                final movie = state.trendingWeekList[index];
                final isCurrentPage = index == state.currentPage;
                return _buildPageItem(
                    movie: movie, isCurrentPage: isCurrentPage, index: index);
              },
              options: CarouselOptions(
                  initialPage: state.currentPage,
                  viewportFraction: 0.68,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    viewModel.setCurrentPage(index);
                  },
                  height: AppDimensions.isCurrentPageHeight),
            )),
        _buildPageIndicator(
          itemCount: 6,
        ),
      ],
    );
  }

  Future<void> pageItemOnTap({required int index}) async {}

  Widget _buildPageItem(
      {required Movie movie, required bool isCurrentPage, required int index}) {
    return Center(
      child: GestureDetector(
        onTap: () => pageItemOnTap(index: index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          width: isCurrentPage
              ? AppDimensions.isCurrentPageWidth
              : AppDimensions.pageViewWidth,
          height: isCurrentPage
              ? AppDimensions.isCurrentPageHeight
              : AppDimensions.pageViewHeight,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: MovieImage(movie: movie),
        ),
      ),
    );
  }

  Widget _buildPageIndicator({required int itemCount}) {
    return Column(
      children: [
        SizedBox(
          height: AppDimensions.sizedBox18,
        ),
        Center(
          child: AnimatedSmoothIndicator(
            count: itemCount,
            effect: ExpandingDotsEffect(
              activeDotColor: selectedItemColor,
              dotColor: dotColor,
              dotHeight: AppDimensions.dotSize,
              dotWidth: AppDimensions.dotSize,
              spacing: AppDimensions.dotSize,
              expansionFactor: 1.00000001,
            ),
            activeIndex: state.currentPage,
          ),
        ),
      ],
    );
  }
}
