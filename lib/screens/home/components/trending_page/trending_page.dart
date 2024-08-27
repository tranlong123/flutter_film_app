import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/screens/home/components/trending_page/page_indicator.dart';
import 'package:flutter_mvvm_riverpod/screens/home/components/trending_page/page_view_item.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';


class TrendingPage extends StatefulWidget {
  final List<Movie> movies;

  const TrendingPage({super.key, required this.movies});

  @override
  TrendingPageState createState() => TrendingPageState();
}

class TrendingPageState extends State<TrendingPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.7)
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
    AppDimensions.init(context);
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
              return PageViewItem(movie: movie, isCurrentPage: isCurrentPage);
            },
          ),
        ),
        CustomPageIndicator(
          pageController: _pageController,
          itemCount: widget.movies.length,
        ),
      ],
    );
  }
}
