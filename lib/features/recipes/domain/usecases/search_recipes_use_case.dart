import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/features/recipes/domain/repository/recipe_repository.dart';

class SearchRecipesUseCase {
  final RecipeRepository repository;

  SearchRecipesUseCase(this.repository);

  Future<List<Recipe>?> call(String searchQuery) async {
    return await repository.searchSavedRecipe(searchQuery);
  }
}
