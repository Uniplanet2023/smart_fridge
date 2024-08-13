import 'dart:convert';
import 'dart:developer';
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
      final String? userData = SharedPreferencesHelper().getString('userData');

      if (userData == null) {
        throw ServerFailure();
      }

      final Map<String, dynamic> user = jsonDecode(userData);
      final DocumentReference docRef = firestore.collection('recipes').doc();
      final String recipeId = docRef.id;

      final recipeData = {
        'recipeId': recipeId,
        'userId': user['userId'],
        'name': recipe.name,
        'ingredients': recipe.ingredients,
        'instructions': recipe.instructions,
        'cuisine': recipe.cuisine,
        'videoUrl': videoUrl,
        'likes': <String>[],
      };

      await docRef.set(recipeData);
    } catch (e) {
      // Log the error if needed
      log('Error saving recipe: $e');
      throw ServerFailure();
    }
  }
}
