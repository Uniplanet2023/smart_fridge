import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/core/domain_layer_entities/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> generateRecipe(List<Item> ingredients, String cuisine);
  Future<void> saveRecipe(Recipe recipe);
}
