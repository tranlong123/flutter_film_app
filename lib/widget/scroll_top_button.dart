import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';

class ScrollTopButton extends StatelessWidget {
  final VoidCallback scrollToTop;
  const ScrollTopButton({super.key, required this.scrollToTop});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppDimensions.scrollTopIconTop,
      left: AppDimensions.scrollTopIconLeft,
      child: GestureDetector(
        onTap: scrollToTop,
        child: SizedBox(
          width: AppDimensions.scrollTopIconWidth,
          height: AppDimensions.scrollTopIconHeight,
          child: Image.asset('assets/image/scrollTopIcon.png'),
        ),
      ),
    );
  }
}
