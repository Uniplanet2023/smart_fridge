import 'package:isar/isar.dart';
import 'package:smart_fridge/features/recipe_generation/data/models/recipe_model.dart';

abstract class RecipeRepository {
  Future<List<RecipeModel>> fetchRecipes();
  Future<List<RecipeModel>> searchRecipes(String query);
  Future<void> deleteSavedRecipe(Id id);
}
