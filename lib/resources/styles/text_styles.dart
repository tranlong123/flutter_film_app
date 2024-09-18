import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/colors.dart';
import 'package:flutter_mvvm_riverpod/resources/styles/dimensions.dart';

class AppTextStyles {
  //Home screen
  static TextStyle listOfDay = TextStyle(
    fontFamily: 'Roboto',
    fontSize: AppDimensions.fontSize20,
    fontWeight: FontWeight.w700,
    height: 23.44 / 20, // line-height / font-size
    color: black,
  );
  //Movie screen
  static TextStyle releaseDate = TextStyle(
      color: black,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
      fontSize: AppDimensions.fontSize10,
      height: 1.172);

  static TextStyle mayBeLike = TextStyle(
    color: black,
    fontSize: AppDimensions.fontSize20,
    fontWeight: FontWeight.w700,
    height: 1.172,
  );

  // CateBox
  static TextStyle cateBox = TextStyle(
      color: black,
      fontSize: AppDimensions.fontSize10,
      height: 1.172,
      fontWeight: FontWeight.w700);

  // CustomButton
  static TextStyle customButton = TextStyle(
      color: black,
      fontFamily: 'Roboto',
      fontSize: AppDimensions.fontSize13,
      fontWeight: FontWeight.w700,
      height: 1.172);

  static TextStyle searchInput = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    height: 1.1717,
    fontSize: AppDimensions.fontSize18,
    color: textInput,
  );

  static TextStyle trending = TextStyle(
      fontSize: AppDimensions.fontSize30,
      fontWeight: FontWeight.w700,
      height: AppDimensions.lineHeight);
  static TextStyle appBarTitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: AppDimensions.fontSize20,
    fontWeight: FontWeight.w700,
    color: black,
  );

  static TextStyle itemOverview = TextStyle(
      fontFamily: 'Roboto',
      color: black,
      fontWeight: FontWeight.w400,
      fontSize: AppDimensions.fontSize10,
      height: 1.172);

  static TextStyle itemTitle = TextStyle(
      color: black,
      fontWeight: FontWeight.w700,
      height: AppDimensions.lineHeight);
  static TextStyle itemVote = const TextStyle(
    color: black,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    height: 1.172,
  );
}
