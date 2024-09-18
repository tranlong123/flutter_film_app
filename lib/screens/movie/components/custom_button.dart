import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/text_styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.sizedBox88,
      height: AppDimensions.sizedBox29,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), // Bo góc (tuỳ chỉnh)
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25), // Màu shadow (#00000040)
              offset: const Offset(0, 4), // Độ lệch của shadow (0px, 4px)
              blurRadius: 4, // Độ mờ của shadow (4px)
            ),
          ]),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shadowColor: black.withOpacity(0.25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: EdgeInsets.zero),
        onPressed: onPressed,
        child: Text(
          text,
          maxLines: 1,
          style: AppTextStyles.customButton,
        ),
      ),
    );
  }
}
