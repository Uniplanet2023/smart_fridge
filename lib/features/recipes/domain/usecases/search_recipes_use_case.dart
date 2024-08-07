// domain/usecases/search_recipes_usecase.dart

import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/features/recipe_generation/data/models/recipe_model.dart';
import 'package:smart_fridge/features/recipes/domain/repository/recipe_repository.dart';

class SearchRecipesUseCase {
  final RecipeRepository repository;

  SearchRecipesUseCase(this.repository);

  Future<List<RecipeModel>> call(String query) {
    return repository.searchRecipes(query);
  }
}
