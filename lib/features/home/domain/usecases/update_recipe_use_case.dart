import 'package:smart_fridge/features/home/data/models/shared_recipe.dart';
import 'package:smart_fridge/features/home/domain/repositories/shared_recipe_repository.dart';

class UpdateSharedRecipeUseCase {
  final SharedRecipeRepository repository;

  UpdateSharedRecipeUseCase(this.repository);

  Future<void> call(SharedRecipe recipe) async {
    return await repository.updateRecipe(recipe);
  }
}
