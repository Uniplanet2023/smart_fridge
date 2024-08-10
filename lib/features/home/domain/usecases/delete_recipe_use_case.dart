import 'package:smart_fridge/features/home/domain/repositories/shared_recipe_repository.dart';

class DeleteSharedRecipeUseCase {
  final SharedRecipeRepository repository;

  DeleteSharedRecipeUseCase(this.repository);

  Future<void> call(String recipeId) async {
    return await repository.deleteRecipe(recipeId);
  }
}
