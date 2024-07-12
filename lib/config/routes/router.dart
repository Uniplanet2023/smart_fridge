import 'package:flutter/material.dart';
import 'package:smart_fridge/config/routes/names.dart';
import 'package:smart_fridge/features/auth/presentation/pages/forgotten_password_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/signin_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/signup_page.dart';
import 'package:smart_fridge/features/home/presentation/pages/home_page.dart';
import 'package:smart_fridge/features/items/presentation/pages/fridge_items_page.dart';
import 'package:smart_fridge/features/profile/presentation/pages/profile_page.dart';
import 'package:smart_fridge/features/recipes/presentation/pages/recipes_page.dart';
import 'package:smart_fridge/features/add/presentation/pages/add.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // case AppRoutes.authPage:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const AuthScreen(),
    //   );
    case AppRoutes.signinPage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SigninPage(),
      );
    case AppRoutes.signupPage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupPage(),
      );
    case AppRoutes.forgottenPasswordPage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ForgottenPasswordPage(),
      );
    case AppRoutes.homePage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomePage(),
      );
    case AppRoutes.recipesPage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RecipesPage(),
      );
    case AppRoutes.scanReceiptsPage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddPage(),
      );
    case AppRoutes.fridgeItemsPage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FridgeItemsPage(),
      );
    case AppRoutes.profilePage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProfilePage(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
