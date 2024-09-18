// lib/widgets/movie_grid_item.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/screens/movie/movie_screen.dart';

class MovieImage extends StatelessWidget {
  final double? width;
  final double? height;
  final Movie movie;
  final VoidCallback? onTap;
  const MovieImage(
      {required this.movie, super.key, this.width, this.height, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieScreen(id: movie.id),
              ),
            );
          },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
