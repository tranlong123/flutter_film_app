import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/screens/movie/movie_screen.dart';

class CreateMayBeLikeList extends StatelessWidget {
  final List<Movie> movies;
  const CreateMayBeLikeList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final rows = (movies.length / 3).ceil();
    final double itemHeight = AppDimensions.gridItemHeight;
    final double verticalSpacing = AppDimensions.sizedBox29;
    final double gridViewHeight = (itemHeight + verticalSpacing) * rows;

    return SizedBox(
      width: AppDimensions.screenWidth,
      height: gridViewHeight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.sizedBox5),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Số mục trên mỗi hàng
            childAspectRatio:
                100 / 160, // Tỷ lệ chiều rộng/chiều cao của mỗi mục
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: AppDimensions.sizedBox29,
              ),
              child: _buildMovieGridItem(context, movie: movie),
            ); // Sử dụng widget item mới
          },
        ),
      ),
    );
  }

  Widget _buildMovieGridItem(context, {required Movie movie}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieScreen(id: movie.id),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
            left: AppDimensions.sizedBox5, right: AppDimensions.sizedBox5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            fit: BoxFit.cover,
            width: AppDimensions.gridItemWidth,
            height: AppDimensions.gridItemHeight,
          ),
        ),
      ),
    );
  }
}
