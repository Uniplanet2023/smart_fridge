
import 'package:smart_fridge/core/domain_layer_entities/save_recipe.dart';
import 'package:smart_fridge/core/data_layer_models/save_recipe_model.dart';
import 'package:smart_fridge/features/recipes/domain/repository/recipe_repository.dart';

import '../data_sources/recipe_local_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeLocalDataSource localDataSource;

  RecipeRepositoryImpl({required this.localDataSource});

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
}
