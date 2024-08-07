import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/core/helper/isar_helper.dart';
import 'package:smart_fridge/features/recipe_generation/data/models/recipe_model.dart';

class RecipeLocalDataSource {
  RecipeLocalDataSource();

  Future<void> saveRecipe(Recipe recipe) async {
    RecipeModel recipeModel = RecipeModel(
      name: recipe.name,
      cuisine: recipe.cuisine,
      instructions: recipe.instructions,
      ingredients: recipe.ingredients.toString(),
      shared: recipe.shared,
    );
    await IsarHelper.isar.writeTxn(() async {
      await IsarHelper.isar.recipeModels.put(recipeModel);
    });
  }
}
