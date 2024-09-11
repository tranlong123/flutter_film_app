import 'package:flutter/material.dart';

class AppDimensions {
  static late double screenHeight;
  static late double screenWidth;
  static late double aspectRatio;

  //screen size
  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    aspectRatio = size.aspectRatio;
  }

  //fontSize
  static double get lineHeight => 1.172;

  static double get fontSize10 => 10* screenWidth / 340;  
  static double get fontSize13 => 13;

  static double get fontSize15 => 15;

  static double get fontSize20 => 20 * screenWidth / 340;
  static double get fontSize30 => 30;

  //size box
  static double get sizedBox2 => screenWidth * 2 / 340;
  static double get sizedBox3 => screenWidth * 3 / 340;
  static double get sizedBox4 => screenWidth * 4 / 340;
  static double get sizedBox5 => screenWidth * 5 / 340;
  static double get sizedBox9 => screenWidth * 9 / 340;
  static double get sizedBox10 => screenWidth * 10 / 340;
  static double get sizedBox11 => screenWidth * 11 / 340;
  static double get sizedBox12 => screenWidth * 12 / 340;
  static double get sizedBox14 => screenWidth * 14 / 340;
  static double get sizedBox16 => screenWidth * 16 / 340;
  static double get sizedBox17 => screenWidth * 17 / 340;
  static double get sizedBox18 => screenWidth * 18 / 340;
  static double get sizedBox19 => screenWidth * 19 / 340;
  static double get sizedBox20 => screenWidth * 20 / 340;
  static double get sizedBox22 => screenWidth * 22 / 340;
  static double get sizedBox23 => screenWidth * 23 / 340;
  static double get sizedBox28 => screenWidth * 28 / 340;
  static double get sizedBox29 => screenWidth * 29 / 340;
  static double get sizedBox35 => screenWidth * 35 / 340;
  static double get sizedBox44 => screenWidth * 44 / 340;
  static double get sizedBox45 => screenWidth * 45 / 340;
  static double get sizedBox56 => screenWidth * 59 / 340;
  static double get sizedBox80 => screenHeight * 80 / 734;
  static double get sizedBox86 => screenWidth * 86 / 340;
  static double get sizedBox88 => screenWidth * 88 / 340;
  static double get sizedBox116 => screenWidth * 116 / 340;
  static double get sizedBox124 => screenWidth * 124 / 340;
  static double get sizedBox156 => screenWidth * 156 / 340;
  static double get sizedBox158 => screenWidth * 158 / 340;
  static double get sizedBox188 => screenWidth * 188 / 340;
  static double get sizedBox233 => screenWidth * 233 / 340;

  //widget size
  static double get dotSize => screenWidth * 10 / 340;
  static double get heartSize => screenWidth * 18 / 340;
  static double get starSize => screenWidth * 18 / 340;
  static double get searchIconSizeWidth => screenWidth * 19.3 / 340;
  static double get searchIconSizeHeight => screenWidth * 25 / 340;
  static double get gridItemWidth => screenWidth * 100 / 340;
  static double get gridItemHeight => screenWidth * 160 / 340;
  static double get listOfDaySize => screenWidth * 188 / 340;
  static double get listOfDayWidth => screenWidth * 328 / 340;
  static double get pageViewWidth => screenWidth * 178 / 340;
  static double get pageViewHeight => screenWidth * 279 / 340;
  static double get isCurrentPageWidth => screenWidth * 231 / 340;
  static double get isCurrentPageHeight => screenWidth * 329 / 340;
  static double get trendingItemImageWidth => screenWidth * 75 / 340;
  static double get trendingItemImageHeight => screenWidth * 115 / 340;
  static double get scrollTopIconWidth => screenWidth * 47 / 340;
  static double get scrollTopIconHeight => screenWidth * 23 / 340;
  static double get scrollTopIconLeft => screenWidth * 146 / 340;
  static double get scrollTopIconTop => screenWidth * 65 / 340;
}
