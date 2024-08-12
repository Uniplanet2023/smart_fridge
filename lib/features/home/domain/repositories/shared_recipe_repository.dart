import 'package:smart_fridge/features/home/data/models/shared_recipe.dart';

abstract class SharedRecipeRepository {
  Future<List<SharedRecipe>> fetchRecipes();
  Future<void> deleteRecipe(String recipeId);
  Future<void> updateRecipe(SharedRecipe recipe);
  Future<void> likeSharedRecipe(String recipeId, String userId);
}
