import 'package:smart_fridge/core/domain_layer_entities/save_recipe.dart';
import 'package:smart_fridge/features/recipes/domain/repository/recipe_repository.dart';

class DeleteRecipesUseCase {
  final RecipeRepository repository;

  DeleteRecipesUseCase(this.repository);

  Future<void> call(SaveRecipe recipe) async {
    await repository.deleteSavedRecipe(recipe);
  }
}
