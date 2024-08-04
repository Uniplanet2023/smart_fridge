// recipe_repository.dart (in domain/repositories)
import 'package:smart_fridge/core/isar_models/item.dart';
import 'package:smart_fridge/core/entities/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> generateRecipe(List<Item> ingredients, String cuisine);
  Future<void> saveRecipe(Recipe recipe);
}
