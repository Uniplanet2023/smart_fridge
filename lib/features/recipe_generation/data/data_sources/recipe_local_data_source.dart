import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:smart_fridge/core/data_layer_models/recipe_model.dart';
import 'package:smart_fridge/core/helper/isar_helper.dart';
import 'package:smart_fridge/core/data_layer_models/save_recipe_model.dart';

class RecipeLocalDataSource {
  RecipeLocalDataSource();

  Future<void> saveRecipe(RecipeModel recipe) async {
    SaveRecipeModel recipeModel = SaveRecipeModel(
      name: recipe.name,
      cuisine: recipe.cuisine,
      instructions: recipe.instructions,
      ingredients:
          recipe.ingredients.map((ingredient) => ingredient.name).toList(),
      shared: recipe.shared,
    );


    // Check if the recipe already exists
    final exists = await _recipeExists(recipeModel);

    if (exists) {
      throw RecipeAlreadyExistsException('The recipe is already saved.');
    }

    await IsarHelper.isar.writeTxn(() async {
      await IsarHelper.isar.saveRecipeModels.put(recipeModel);
    });
  }

  Future<bool> _recipeExists(SaveRecipeModel recipeModel) async {
    // Query the database to see if a recipe with the same name and cuisine exists
    final existingRecipes = await IsarHelper.isar.saveRecipeModels
        .filter()
        .nameEqualTo(recipeModel.name)
        .cuisineEqualTo(recipeModel.cuisine)
        .findAll();

    // comparing ingredients and instructions, if they are the same, recipe is already saved
    for (final existingRecipe in existingRecipes) {
      if (listEquals(existingRecipe.ingredients, recipeModel.ingredients) &&
          listEquals(existingRecipe.instructions, recipeModel.instructions) &&
          existingRecipe.shared == recipeModel.shared) {
        return true;
      }
    }

    return false;
  }
}

class RecipeAlreadyExistsException implements Exception {
  final String message;
  RecipeAlreadyExistsException(this.message);

  @override
  String toString() => message;
}
