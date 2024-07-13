import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_fridge/config/routes/router.dart';
import 'package:smart_fridge/config/styles/app_font_size.dart';
import 'package:smart_fridge/config/widgets/bottom_bar.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smart_fridge/features/auth/presentation/pages/signin_page.dart';

import 'config/styles/app_text_style.dart';

void main() async {
  // Initialize Firebase and set system UI overlay style
  await Initialization.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
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
      title: 'Smart Fridge',
      onGenerateRoute: (settings) => generateRoute(settings),
      theme: ThemeData(
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
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondaryFixedDim),
          ),
          hintStyle: const TextStyle(fontSize: AppFontSize.medium),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondaryFixedDim),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2.0,
            ),
          ),
        ),
        colorScheme:
            // ColorScheme.fromSeed(seedColor: const Color(0xff6200ee))
            ThemeData.light().colorScheme.copyWith(
                  secondary: const Color.fromRGBO(52, 78, 65, 1),
                ),
      ),
      darkTheme: ThemeData(
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
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.black,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondaryFixedDim),
          ),
          hintStyle: const TextStyle(fontSize: AppFontSize.medium),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondaryFixedDim),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2.0,
            ),
          ),
        ),
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoaded) {
            return const BottomBar();
          }
          return const SigninPage();
        },
      ),
    );
  }
}
