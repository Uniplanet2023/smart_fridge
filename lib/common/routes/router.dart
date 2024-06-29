import 'package:flutter/material.dart';
import 'package:smart_fridge/common/routes/names.dart';
import 'package:smart_fridge/features/home/screens/home_screen.dart';
import 'package:smart_fridge/features/items/screens/fridge_items.dart';
import 'package:smart_fridge/features/profile/screens/profile_screen.dart';
import 'package:smart_fridge/features/recipes/screens/recipes_screen.dart';
import 'package:smart_fridge/features/scan-receipts/scan_receipts.dart';

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
