// lib/widgets/movie_grid_item.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/screens/movie/movie_screen.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MovieScreen(),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          fit: BoxFit.cover,
          width: AppDimensions.gridItemWidth,
          height: AppDimensions.gridItemHeight,
        ),
      ),
    );
  }
}
