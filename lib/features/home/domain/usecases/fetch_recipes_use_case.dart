import 'package:smart_fridge/features/home/data/models/shared_recipe.dart';
import 'package:smart_fridge/features/home/domain/repositories/shared_recipe_repository.dart';

class FetchSharedRecipesUseCase {
  final SharedRecipeRepository repository;

  FetchSharedRecipesUseCase(this.repository);

  Future<List<SharedRecipe>> call() async {
    return await repository.fetchRecipes();
  }
}
