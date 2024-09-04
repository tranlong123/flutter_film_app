import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';

class StartVote extends StatelessWidget {
  final double vote;
  const StartVote({super.key, required this.vote});

  int _calculateStars(double voteAverage) {
    if (voteAverage <= 1) {
      return 0;
    } else if (voteAverage <= 3) {
      return 1;
    } else if (voteAverage <= 5) {
      return 2;
    } else if (voteAverage <= 7) {
      return 3;
    } else if (voteAverage <= 9) {
      return 4;
    } else {
      return 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    int numberOfStars = _calculateStars(vote);
    AppDimensions.init(context);
    return Padding(
      padding: EdgeInsets.only(top: AppDimensions.sizedBox2),
      child: Row(
        children: List.generate(5, (index) {
          return Icon(
            Icons.star,
            color: index < numberOfStars ? start : start2,
            size: AppDimensions.starSize,
          );
        }),
      ),
    );
  }
}
