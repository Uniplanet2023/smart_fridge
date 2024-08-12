import 'package:smart_fridge/features/home/domain/repositories/shared_recipe_repository.dart';

class LikeSharedRecipeUseCase {
  final SharedRecipeRepository repository;

  LikeSharedRecipeUseCase(this.repository);

  Future<void> call(String recipeId, String userId) async {
    await repository.likeSharedRecipe(recipeId, userId);
  }
}
