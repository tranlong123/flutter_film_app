import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';

class ItemTitle extends StatelessWidget {
  final double? width;
  final String title;
  const ItemTitle({super.key, required this.title, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? AppDimensions.sizedBox156,
      height: AppDimensions.sizedBox23,
      // height: 23.44,
      child: Text(
        title,
        overflow:
            TextOverflow.ellipsis, // Hiển thị dấu '...' khi vượt quá chiều rộng
        maxLines: 1, // Giới hạn số dòng
        style: TextStyle(
            color: black,
            fontWeight: FontWeight.w700,
            height: AppDimensions.lineHeight),
      ),
    );
  }
}
