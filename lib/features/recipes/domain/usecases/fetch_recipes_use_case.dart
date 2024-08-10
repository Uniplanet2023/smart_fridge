import 'package:smart_fridge/core/domain_layer_entities/save_recipe.dart';
import 'package:smart_fridge/features/recipes/domain/repository/recipe_repository.dart';

class FetchRecipesUseCase {
  final RecipeRepository repository;

  FetchRecipesUseCase(this.repository);

  Future<List<SaveRecipe>> call() {
    return repository.fetchRecipes();
  }
}
