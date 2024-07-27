import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/features/recipes/domain/repository/recipe_repository.dart';

class FetchRecipesUseCase {
  final RecipeRepository repository;

  FetchRecipesUseCase(this.repository);

  Future<List<Recipe>?> call() async {
    return await repository.fetchSavedRecipes();
  }
}
