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
    return Column(
      children: [
        SizedBox(
          width: AppDimensions.screenWidth,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.sizedBox10),
            child: Wrap(
              spacing: AppDimensions.sizedBox10,
              runSpacing: AppDimensions.sizedBox29,
              children: movies.map((movie) {
                return _buildMovieGridItem(context, movie: movie);
              }).toList(),
            ),
          ),
        ),
        SizedBox(height: AppDimensions.sizedBox29)
      ],
    );
  }

  Widget _buildMovieGridItem(BuildContext context, {required Movie movie}) {
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
        width: AppDimensions.gridItemWidth,
        height: AppDimensions.gridItemHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
