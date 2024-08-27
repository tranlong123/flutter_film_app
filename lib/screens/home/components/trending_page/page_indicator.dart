import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../resources/styles/colors.dart';
import '../../../../resources/styles/dimensions.dart';

class CustomPageIndicator extends StatelessWidget {
  final PageController pageController;
  final int itemCount;

  const CustomPageIndicator({
    super.key,
    required this.pageController,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppDimensions.sizedBox18,
        ),
        Center(
          child: SmoothPageIndicator(
            controller: pageController,
            count: itemCount,
            effect:  ExpandingDotsEffect(
              activeDotColor: selectedItemColor,
              dotColor: dotColor,
              dotHeight: AppDimensions.dotSize,
              dotWidth: AppDimensions.dotSize,
              spacing: AppDimensions.dotSize,
              expansionFactor: 1.00000001,
            ),
          ),
        ),
      ],
    );
  }
}
