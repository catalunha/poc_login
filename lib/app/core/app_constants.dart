import 'package:flutter/material.dart';

sealed class AppColors {
  static const white = Color(0xFFffffff);
  static const black = Color(0xFF000000);
  static const red = Color.fromARGB(255, 255, 0, 0);
  static const blue = Color.fromARGB(255, 150, 203, 233);
}

sealed class AppFontFamily {
  static const fontFamily1 = 'Poppins';
}

sealed class AppAssetImage {
  static const logo = '';
}

const String apiAccessTokenName = 'access';
