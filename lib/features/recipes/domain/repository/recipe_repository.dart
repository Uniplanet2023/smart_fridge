import 'package:isar/isar.dart';
import 'package:smart_fridge/core/entities/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> fetchSavedRecipes();
  Future<List<Recipe>> searchSavedRecipe(String searchQuery);
  Future<void> deleteSavedRecipe(Id id);
}
