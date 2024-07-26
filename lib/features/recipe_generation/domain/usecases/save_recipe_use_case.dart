import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/features/recipe_generation/domain/repository/recipe_generation_repository.dart';

class SaveRecipeUseCase {
  final RecipeRepository repository;

  SaveRecipeUseCase(this.repository);

  Future<void> call(Recipe recipe) {
    return repository.saveRecipe(recipe);
  }
}
