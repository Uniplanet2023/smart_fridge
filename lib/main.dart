import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_fridge/config/widgets/bottom_bar.dart';
import 'package:smart_fridge/core/resources/initialization.dart';

void main() async {
  // Initialize Firebase and set system UI overlay style
  await Initialization.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // GlobalKey for the navigator
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: GoogleFonts.poppins().fontFamily,
          colorScheme:
              // ColorScheme.fromSeed(seedColor: const Color(0xff6200ee))
              ThemeData.light().colorScheme.copyWith(
                    secondary: const Color.fromRGBO(52, 78, 65, 1),
                  )),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const BottomBar(),
    );
  }
}
