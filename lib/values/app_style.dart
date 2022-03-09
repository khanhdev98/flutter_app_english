import 'package:flutter/material.dart';

import 'app_colors.dart';

class FontFamily {
  static const String sen = 'Sen';
}

class AppStyles {
  static const TextStyle h1 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 109, color: AppColors.textColor);
  static const TextStyle h2 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 68, color: AppColors.textColor);
  static const TextStyle h3 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 42, color: AppColors.textColor);
  static const TextStyle h4 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 26, color: AppColors.textColor);
  static const TextStyle h5 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 16, color: AppColors.textColor);
  static const TextStyle h6 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 9.8, color: AppColors.textColor);
}
