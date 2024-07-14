import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_fridge/config/styles/app_font_size.dart';
import 'package:smart_fridge/config/styles/app_text_style.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: const TextTheme(
    headlineLarge: AppTextStyle.xxxLargeBlack,
    headlineMedium: AppTextStyle.xLargeBlack,
    titleMedium: AppTextStyle.xSmallBlack,
    titleSmall: AppTextStyle.smallBlack,
    bodyLarge: AppTextStyle.largeBlack,
    bodyMedium: AppTextStyle.mediumBlack,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: const Color(0xff6750a4),
      foregroundColor: Colors.white,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xffccc2dc),
      ),
    ),
    hintStyle: TextStyle(fontSize: AppFontSize.medium),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffccc2dc)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff6200ee),
        width: 2.0,
      ),
    ),
  ),
  colorScheme:
      // ColorScheme.fromSeed(seedColor: const Color(0xff6200ee))
      ThemeData.light().colorScheme.copyWith(
            secondary: const Color.fromRGBO(52, 78, 65, 1),
          ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: const TextTheme(
    headlineLarge: AppTextStyle.xxxLargeWhite,
    headlineMedium: AppTextStyle.xLargeWhite,
    titleMedium: AppTextStyle.xSmallWhite,
    titleSmall: AppTextStyle.smallWhite,
    bodyLarge: AppTextStyle.largeWhite,
    bodyMedium: AppTextStyle.mediumWhite,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: const Color(0xff6750a4),
      foregroundColor: Colors.black,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xffccc2dc),
      ),
    ),
    hintStyle: TextStyle(fontSize: AppFontSize.medium),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xffccc2dc),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff6750a4),
        width: 2.0,
      ),
    ),
  ),
);
