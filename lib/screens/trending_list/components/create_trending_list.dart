import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';

class CreateTrendingList extends StatelessWidget {
  final List<Movie> movies;

  const CreateTrendingList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          title: Text(movie.title),
          subtitle: Text(movie.releaseDate),
        );
      },
    );
  }
}
