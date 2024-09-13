import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/widget/movie_image.dart';

class CreateListOfDay extends StatelessWidget {
  final List<Movie> movies;
  const CreateListOfDay({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppDimensions.listOfDayWidth,
        height: AppDimensions.listOfDaySize,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            if (index >= movies.length) return const SizedBox.shrink();
            final movie = movies[index];
            return _buildListItem(movie: movie);
          },
          separatorBuilder: (context, index) =>
              SizedBox(width: AppDimensions.sizedBox14),
        ),
      ),
    );
  }

  Widget _buildListItem({required Movie movie}) {
    return MovieImage(
        movie: movie,
        width: AppDimensions.gridItemWidth,
        height: AppDimensions.gridItemHeight);
  }
}
