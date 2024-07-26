import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/core/helper/isar_helper.dart';

class RecipeLocalDataSource {
  RecipeLocalDataSource();

  Future<void> saveRecipe(Recipe recipe) async {
    IsarHelper.isar.writeTxn(() async {
      // await IsarHelper.isar.recipes.put(recipe);
    });
  }
}
