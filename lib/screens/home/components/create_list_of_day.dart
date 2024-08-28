import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/data/models/movie/movie.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/widget/movie_item.dart';

class CreateListOfDay extends StatelessWidget {
  final List<Movie> movies;
  const CreateListOfDay({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildListOfDayText(),
        _buildListOfDay(movies: movies),
      ],
    );
  }

  Widget _buildListOfDayText() {
    return Padding(
      padding: EdgeInsets.only(
          left: AppDimensions.sizedBox16, bottom: AppDimensions.sizedBox9),
      child: Text(
        'List Of Day',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: AppDimensions.fontSize20,
          fontWeight: FontWeight.w700,
          height: 23.44 / 20, // line-height / font-size
          color: black,
        ),
      ),
    );
  }

  Widget _buildListOfDay({required List<Movie> movies}) {
    return SizedBox(
      width: AppDimensions.listOfDayWidth,
      height: AppDimensions.listOfDaySize,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          if (index >= movies.length) return const SizedBox.shrink();
          final movie = movies[index];
          return MovieItem(movie: movie);
        },
        separatorBuilder: (context, index) =>
            SizedBox(width: AppDimensions.sizedBox14),
      ),
    );
  }
}
