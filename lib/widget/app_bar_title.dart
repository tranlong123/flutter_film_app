// lib/widgets/app_bar_title.dart
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/text_styles.dart';

class AppBarTitle extends StatelessWidget {
  final String? text;

  const AppBarTitle({super.key,  this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'Trending',
      style: AppTextStyles.appBarTitle,
    );
  }
}
