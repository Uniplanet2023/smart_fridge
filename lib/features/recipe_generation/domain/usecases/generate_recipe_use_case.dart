import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/core/domain_layer_entities/recipe.dart';
import 'package:smart_fridge/features/recipe_generation/domain/repository/recipe_generation_repository.dart';

class GenerateRecipeUseCase {
  final RecipeRepository repository;

  GenerateRecipeUseCase(this.repository);

  Future<List<Recipe>> call(List<Item> ingredients, String cuisine) {
    return repository.generateRecipe(ingredients, cuisine);
  }
}
