import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';

class ItemOverview extends StatelessWidget {
  final String text;
  final int? maxLines;
  final double? height;
  const ItemOverview({super.key, required this.text, this.maxLines, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height?? AppDimensions.sizedBox56,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines ?? 5,
        style: TextStyle(
            fontFamily: 'Roboto',
            color: black,
            fontWeight: FontWeight.w400,
            fontSize: AppDimensions.fontSize10,
            height: 1.172
            ),
      ),
    );
  }
}
