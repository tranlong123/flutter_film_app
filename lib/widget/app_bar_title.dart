// lib/widgets/app_bar_title.dart
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';

class AppBarTitle extends StatelessWidget {
  final double? fontSize;
  final String? text;

  const AppBarTitle({super.key, this.fontSize, this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'Trending',
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: fontSize ?? AppDimensions.fontSize20,
        fontWeight: FontWeight.w700,
        color: black,
      ),
    );
  }
}
