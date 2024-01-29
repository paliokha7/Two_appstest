import 'package:flutter/material.dart';

class Pallete {
  // Colors
  static const Color blackColor = Color.fromRGBO(37, 37, 37, 1);
  static const Color greyColor = Color.fromRGBO(26, 39, 45, 1);
  static const Color whiteColor = Colors.white;

  // Theme

  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: blackColor,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    backgroundColor: blackColor,
  );
}
