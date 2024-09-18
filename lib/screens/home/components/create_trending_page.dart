import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/screens/movie/movie_screen.dart';
import 'package:flutter_mvvm_riverpod/widget/movie_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreateTrendingPage extends StatefulWidget {
  final List<Movie> trendingWeekList;
  final bool isLoading;
  const CreateTrendingPage(
      {super.key, required this.isLoading, required this.trendingWeekList});

  @override
  CreateTrendingPageState createState() => CreateTrendingPageState();
}

class CreateTrendingPageState extends State<CreateTrendingPage> {
  int _currentPage = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
  }

  void setCurrentPage(int i) {
    setState(() {
      _currentPage = i;
    });
  }

  void clickPage(int i, int id) {
    if (i == _currentPage) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieScreen(id: id),
        ),
      );
    } else {
      setCurrentPage(i);
      _carouselController.animateToPage(
        i,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Container();
    } else if (!widget.isLoading && widget.trendingWeekList.isEmpty) {
      return const Center(child: Text('Không có dữ liệu'));
    }
    return Column(
      children: [
        SizedBox(
            height: AppDimensions.isCurrentPageHeight,
            child: CarouselSlider.builder(
              itemCount: widget.trendingWeekList.length,
              carouselController: _carouselController,
              itemBuilder: (context, index, realIndex) {
                final movie = widget.trendingWeekList[index];
                final isCurrentPage = index == _currentPage;
                return _buildPageItem(
                    movie: movie, isCurrentPage: isCurrentPage, index: index);
              },
              options: CarouselOptions(
                initialPage: _currentPage,
                viewportFraction: 0.68,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setCurrentPage(index);
                },
                height: AppDimensions.isCurrentPageHeight,
              ),
            )),
        _buildPageIndicator(
          itemCount: 6,
        ),
      ],
    );
  }

  Widget _buildPageItem(
      {required Movie movie, required bool isCurrentPage, required int index}) {
    return Center(
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
          child: MovieImage(
              movie: movie, onTap: () => clickPage(index, movie.id))),
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
            activeIndex: _currentPage,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
