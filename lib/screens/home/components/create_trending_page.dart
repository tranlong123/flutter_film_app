import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/widget/movie_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreateTrendingPage extends StatefulWidget {
  final List<Movie> movies;

  const CreateTrendingPage({super.key, required this.movies});

  @override
  CreateTrendingPageState createState() => CreateTrendingPageState();
}

class CreateTrendingPageState extends State<CreateTrendingPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.68)
      ..addListener(() {
        final page = _pageController.page ?? 0;
        setState(() {
          _currentPage = page.round();
        });
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          // Đặt chiều cao cụ thể cho PageView
          height: AppDimensions.isCurrentPageHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              final isCurrentPage = index == _currentPage;
              return _buildPageItem(
                  movie: movie, isCurrentPage: isCurrentPage, index: index);
            },
          ),
        ),
        _buildPageIndicator(
          pageController: _pageController,
          itemCount: 6,
        ),
      ],
    );
  }

  Future<void> pageItemOnTap({required int index}) async {
    setState(() {
      _currentPage = index;
    });
    await _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    // Navigator.push(
    // context,
    // MaterialPageRoute(
    //   builder: (context) => MovieScreen(movie: widget.movie),
    // ),
    // );
  }

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
          child: MovieImage(movie: movie)
        ),
      ),
    );
  }

  Widget _buildPageIndicator(
      {required PageController pageController, required int itemCount}) {
    return Column(
      children: [
        SizedBox(
          height: AppDimensions.sizedBox18,
        ),
        Center(
          child: SmoothPageIndicator(
            controller: pageController,
            count: itemCount,
            effect: ExpandingDotsEffect(
              activeDotColor: selectedItemColor,
              dotColor: dotColor,
              dotHeight: AppDimensions.dotSize,
              dotWidth: AppDimensions.dotSize,
              spacing: AppDimensions.dotSize,
              expansionFactor: 1.00000001,
            ),
          ),
        ),
      ],
    );
  }
}
