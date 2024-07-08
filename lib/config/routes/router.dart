import 'package:flutter/material.dart';
import 'package:smart_fridge/config/routes/names.dart';
import 'package:smart_fridge/features/home/presentation/pages/home_screen.dart';
import 'package:smart_fridge/features/items/presentation/pages/fridge_items.dart';
import 'package:smart_fridge/features/profile/presentation/pages/profile_screen.dart';
import 'package:smart_fridge/features/recipes/presentation/pages/recipes_screen.dart';
import 'package:smart_fridge/features/add/presentation/pages/add.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // case AppRoutes.authPage:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const AuthScreen(),
    //   );
    // case AppRoutes.signupPage:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const SignupScreen(),
    //   );
    // case AppRoutes.signupPage:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const SignupScreen(),
    //   );
    case AppRoutes.homePage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case AppRoutes.recipesPage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RecipesScreen(),
      );
    case AppRoutes.scanReceiptsPage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ScanReceiptsScreen(),
      );
    case AppRoutes.fridgeItemsPage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FridgeItemsScreen(),
      );
    case AppRoutes.profilePage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProfileScreen(),
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
