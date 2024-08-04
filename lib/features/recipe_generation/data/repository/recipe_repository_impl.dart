import 'package:smart_fridge/core/isar_models/item.dart';
import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/features/recipe_generation/data/data_sources/recipe_local_data_source.dart';
import 'package:smart_fridge/features/recipe_generation/data/data_sources/recipe_remote_data_source.dart';
import 'package:smart_fridge/features/recipe_generation/domain/repository/recipe_generation_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;
  final RecipeLocalDataSource localDataSource;

  RecipeRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<List<Recipe>> generateRecipe(List<Item> ingredients, String cuisine) {
    return remoteDataSource.generateRecipe(ingredients, cuisine);
  }

  @override
  Future<void> saveRecipe(Recipe recipe) {
    return localDataSource.saveRecipe(recipe);
  }
}
