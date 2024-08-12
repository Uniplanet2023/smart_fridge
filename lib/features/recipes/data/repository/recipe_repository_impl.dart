import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_fridge/core/domain_layer_entities/save_recipe.dart';
import 'package:smart_fridge/core/data_layer_models/save_recipe_model.dart';
import 'package:smart_fridge/core/error/failures.dart';
import 'package:smart_fridge/core/helper/shared_preferences_helper.dart';
import 'package:smart_fridge/features/recipes/domain/repository/recipe_repository.dart';

import '../data_sources/recipe_local_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeLocalDataSource localDataSource;
  final FirebaseFirestore firestore;

  RecipeRepositoryImpl(
      {required this.localDataSource, required this.firestore});

  @override
  Future<List<SaveRecipe>> fetchRecipes() async {
    final saveRecipeModels = await localDataSource.fetchRecipes();
    return saveRecipeModels.map((model) => model.toDomain()).toList();
  }

  @override
  Future<List<SaveRecipe>> searchRecipes(String query) async {
    final saveRecipeModels = await localDataSource.searchRecipes(query);
    return saveRecipeModels.map((model) => model.toDomain()).toList();
  }

  @override
  Future<void> deleteSavedRecipe(SaveRecipe recipe) async {
    final saveRecipeModel = SaveRecipeModel.fromDomain(recipe);
    await localDataSource.deleteSavedRecipe(saveRecipeModel);
  }

  @override
  Future<void> saveRecipeOnFirebase(SaveRecipe recipe, String videoUrl) async {
    try {
      String? userData = SharedPreferencesHelper().getString('userData');
      late final user;
      if (userData == null) {
        throw ServerFailure();
      } else {
        user = jsonDecode(userData);
      }
      await firestore.collection('recipes').doc().set({
        'userId': user['userId'],
        'name': recipe.name,
        'ingredients': recipe.ingredients,
        'instructions': recipe.instructions,
        'cuisine': recipe.cuisine,
        'pictureUrl': videoUrl,
        'likes': [],
      });
    } catch (e) {
      throw ServerFailure();
    }
  }
}
