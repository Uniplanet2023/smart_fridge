import 'dart:convert';

import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/core/isar_models/item.dart';
import 'package:smart_fridge/features/recipe_generation/data/models/recipe_model.dart';
import 'package:smart_fridge/features/recipes/domain/repository/recipe_repository.dart';

import '../datasources/recipe_local_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeLocalDataSource localDataSource;

  RecipeRepositoryImpl({required this.localDataSource});

  @override
  Future<List<RecipeModel>> fetchRecipes() async {
    return await localDataSource.fetchRecipes();
  }

  @override
  Future<List<RecipeModel>> searchRecipes(String query) async {
    return await localDataSource.searchRecipes(query);
  }

  @override
  Future<void> deleteSavedRecipe(int id) async {
    await localDataSource.deleteSavedRecipe(id);
  }
}
