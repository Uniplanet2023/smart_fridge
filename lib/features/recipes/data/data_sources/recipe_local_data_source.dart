import 'package:isar/isar.dart';
import 'package:smart_fridge/core/helper/isar_helper.dart';
import 'package:smart_fridge/core/data_layer_models/save_recipe_model.dart';

class RecipeLocalDataSource {
  final Isar isar = IsarHelper.isar;
  RecipeLocalDataSource();
  Future<List<SaveRecipeModel>> fetchRecipes() async {
    return IsarHelper.isar.saveRecipeModels.where().findAll();
  }

  Future<List<SaveRecipeModel>> searchRecipes(String query) async {
    return await IsarHelper.isar.saveRecipeModels
        .filter()
        .nameContains(query, caseSensitive: false)
        .findAll();
  }

  Future<void> deleteSavedRecipe(SaveRecipeModel recipe) async {
    await isar.writeTxn(() async {
      await isar.saveRecipeModels.delete(recipe.id);
    });
  }
}
