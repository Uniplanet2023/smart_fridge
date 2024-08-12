import 'package:smart_fridge/core/domain_layer_entities/save_recipe.dart';
import 'package:smart_fridge/features/recipes/domain/repository/recipe_repository.dart';

class SearchRecipesUseCase {
  final RecipeRepository repository;

  SearchRecipesUseCase(this.repository);

  Future<List<SaveRecipe>> call(String query) {
    return repository.searchRecipes(query);
  }
}
