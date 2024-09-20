import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/text_styles.dart';

class CateBox extends StatelessWidget {
  final String cate;
  const CateBox({super.key, required this.cate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.sizedBox18,
      decoration: BoxDecoration(
        color: cateColor,
        borderRadius: BorderRadius.circular(50)
      ),
      child:  Padding(
        padding: EdgeInsets.symmetric(horizontal:AppDimensions.sizedBox9 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cate,
              style: AppTextStyles.cateBox
            ),
          ],
        ),
      ),
    );
  }
}