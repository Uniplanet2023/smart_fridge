import 'package:flutter/material.dart';
import 'package:smart_fridge/config/routes/names.dart';
import 'package:smart_fridge/config/widgets/bottom_bar.dart';
import 'package:smart_fridge/core/domain_layer_entities/recipe.dart';
import 'package:smart_fridge/core/domain_layer_entities/save_recipe.dart';
import 'package:smart_fridge/features/auth/presentation/pages/change_password_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/forgotten_password_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/signin_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/signup_page.dart';
import 'package:smart_fridge/features/fridge_management/presentation/pages/add_fridge_items_page.dart';
import 'package:smart_fridge/features/home/presentation/pages/home.dart';
import 'package:smart_fridge/features/recipe_generation/presentation/pages/generated_recipes_page.dart';
import 'package:smart_fridge/features/recipes/presentation/pages/post_recipe_image.dart';
import 'package:smart_fridge/features/fridge_management/presentation/pages/fridge_items_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/account_settings_page.dart';
import 'package:smart_fridge/features/auth/presentation/pages/profile_page.dart';
import 'package:smart_fridge/features/recipes/presentation/pages/recipes_page.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/pages/add_page.dart';
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
    case AppRoutes.saveRecipeDetailPage:
      SaveRecipe recipe = routeSettings.arguments as SaveRecipe;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SavedRecipeDetailsPage(recipe: recipe),
      );
    case AppRoutes.generatedRecipesPage:
      //routeSettings.arguments as SaveRecipe;
      final generatedRecipes = routeSettings.arguments as List<Recipe>;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>
            GeneratedRecipesPage(generatedRecipes: generatedRecipes),
      );
    case AppRoutes.homePage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomePage(),
      );
    case AppRoutes.bottomBarPage:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
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
    case AppRoutes.postRecipeImagePage:
      final recipe = routeSettings.arguments as SaveRecipe;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => PostRecipeImagePage(
          recipe: recipe,
        ),
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
