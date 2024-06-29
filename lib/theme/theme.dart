import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Color.fromRGBO(218, 215, 205, 1),
    surfaceDim: Color.fromRGBO(202, 210, 197, 1),
    primary: Color.fromRGBO(58, 90, 64, 1),
    primaryFixedDim: Color.fromRGBO(52, 78, 65, 1),
    secondary: Color.fromARGB(255, 135, 164, 239),
    secondaryFixedDim: Color.fromRGBO(238, 238, 238, 1),
    tertiary: Colors.black,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color.fromRGBO(58, 90, 64, 1),
  ),
  fontFamily: GoogleFonts.roboto().fontFamily,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  useMaterial3: true,
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color.fromRGBO(47, 62, 70, 1),
    surfaceDim: Color.fromRGBO(53, 79, 82, 1),
    primary: Color.fromRGBO(58, 90, 64, 1),
    primaryFixedDim: Color.fromRGBO(52, 78, 65, 1),
    secondary: Colors.black54,
    secondaryFixedDim: Color.fromRGBO(66, 66, 66, 1),
    tertiary: Colors.white,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color.fromRGBO(58, 90, 64, 1),
  ),
  fontFamily: GoogleFonts.roboto().fontFamily,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  useMaterial3: true,
);
