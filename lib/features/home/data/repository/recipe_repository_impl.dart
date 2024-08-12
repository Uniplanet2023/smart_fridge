import 'package:smart_fridge/features/home/data/data_sources/recipe_remote_data_source.dart';
import 'package:smart_fridge/features/home/data/models/shared_recipe.dart';
import 'package:smart_fridge/features/home/domain/repositories/shared_recipe_repository.dart';

class SharedRecipeRepositoryImpl implements SharedRecipeRepository {
  final SharedRecipeRemoteDataSource remoteDataSource;

  SharedRecipeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<SharedRecipe>> fetchRecipes() async {
    return await remoteDataSource.fetchRecipes();
  }

  @override
  Future<void> deleteRecipe(String recipeId) async {
    return await remoteDataSource.deleteRecipe(recipeId);
  }

  @override
  Future<void> updateRecipe(SharedRecipe recipe) async {
    return await remoteDataSource.updateRecipe(recipe);
  }

  @override
  Future<void> likeSharedRecipe(String recipeId, String userId) async {
    await remoteDataSource.likeSharedRecipe(recipeId, userId);
  }
}
