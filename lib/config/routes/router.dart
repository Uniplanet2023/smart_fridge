import 'package:flutter/material.dart';
import 'package:smart_fridge/config/routes/names.dart';
import 'package:smart_fridge/features/auth/presentation/pages/change_password_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/forgotten_password_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/signin_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/signup_page.dart';
import 'package:smart_fridge/features/fridge_management/presentation/pages/add_fridge_items_page.dart';
import 'package:smart_fridge/features/video_sharing/presentation/pages/home_page.dart';
import 'package:smart_fridge/features/fridge_management/presentation/pages/fridge_items_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/account_settings_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/profile_page.dart';
import 'package:smart_fridge/features/recipes/presentation/pages/recipes_page.dart';
import 'package:smart_fridge/features/recipe_generation/presentation/pages/add.dart';
import 'package:smart_fridge/features/recipes/presentation/pages/saved_recipe_details_page.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
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
    case AppRoutes.savedRecipeDetailsPage:
      //  var recipe = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SavedRecipeDetailsPage(),
      );
    case AppRoutes.accountSettingsPage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AccountSettingsPage(),
      );
    case AppRoutes.changePasswordPage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ChangePasswordPage(),
      );
    case AppRoutes.addFridgeItemsPage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddFridgeItemsPage(),
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
