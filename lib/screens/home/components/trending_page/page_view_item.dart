import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';

import '../../../../resources/styles/colors.dart';


class PageViewItem extends StatefulWidget {
  final Movie movie;
  final bool isCurrentPage;
  const PageViewItem({
    super.key,
    required this.movie,
    required this.isCurrentPage,
  });

  @override
  PageViewItemState createState() => PageViewItemState();
}

class PageViewItemState extends State<PageViewItem> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
            // context,
            // MaterialPageRoute(
            //   builder: (context) => MovieScreen(movie: widget.movie),
            // ),
          // );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          width: widget.isCurrentPage
              ? AppDimensions.isCurrentPageWidth
              : AppDimensions.pageViewWidth,
          height: widget.isCurrentPage
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.movie.posterPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
