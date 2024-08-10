import 'package:smart_fridge/core/domain_layer_entities/recipe.dart';
import 'package:smart_fridge/core/domain_layer_entities/save_recipe.dart';
import 'package:smart_fridge/features/recipes/domain/entities/shared_recipe.dart';

abstract class RecipeRepository {
  Future<List<SaveRecipe>> fetchRecipes();
  Future<List<SaveRecipe>> searchRecipes(String query);
  Future<void> deleteSavedRecipe(SaveRecipe recipe);
  Future<void> saveRecipeOnFirebase(SaveRecipe recipe, String videoUrl);
}
