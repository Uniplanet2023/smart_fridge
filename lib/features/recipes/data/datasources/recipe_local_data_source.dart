import 'package:isar/isar.dart';
import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/core/helper/isar_helper.dart';
import 'package:smart_fridge/features/recipe_generation/data/models/recipe_model.dart';

class RecipeLocalDataSource {
  RecipeLocalDataSource();

  Future<List<RecipeModel>> fetchRecipes() async {
    return IsarHelper.isar.recipeModels.where().findAll();
  }

  Future<List<RecipeModel>> searchRecipes(String query) async {
    return await IsarHelper.isar.recipeModels
        .filter()
        .nameContains(query, caseSensitive: false)
        .findAll();
  }

  Future<void> deleteSavedRecipe(int id) async {
    await IsarHelper.isar.recipeModels.delete(id);
  }
}
