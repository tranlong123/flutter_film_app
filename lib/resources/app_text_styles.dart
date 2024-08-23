import 'package:flutter/material.dart';

import 'gen/colors.gen.dart';
import 'gen/fonts.gen.dart';

class AppTextStyles {
  AppTextStyles._();
  static const defaultStyle = TextStyle(
    fontFamily: FontFamily.notoSans,
    color: ColorName.black,
  );

  static final bottomBarItemOn = defaultStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: ColorName.blue,
  );

  static final bottomBarItem = defaultStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );

  static final s30w600 = defaultStyle.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );

  static final s16w400 = defaultStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static final s16w700 = defaultStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static final s14w400 = defaultStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final s20w400 = defaultStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
}
