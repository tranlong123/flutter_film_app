import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';

class CustomButtom extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const CustomButtom({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return SizedBox(
      width: AppDimensions.sizedBox88,
      height: AppDimensions.sizedBox29,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: EdgeInsets.zero
        ),
        onPressed: onPressed,
        child: Text(
          text,
          maxLines: 1,
          style: TextStyle(
              color: black,
              fontFamily: 'Roboto',
              fontSize: AppDimensions.fontSize13,
              fontWeight: FontWeight.w700,
              height: 1.172),
        ),
      ),
    );
  }
}
