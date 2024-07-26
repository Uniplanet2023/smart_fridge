import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/features/recipe_generation/domain/repository/recipe_generation_repository.dart';

class GenerateRecipeUseCase {
  final RecipeGenerationRepository repository;

  GenerateRecipeUseCase(this.repository);

  Future<Recipe?> call(List<String> ingridients, String cuisine) async {
    return await repository.generateRecipe(ingridients, cuisine);
  }
}
