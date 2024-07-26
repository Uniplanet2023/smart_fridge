import 'package:smart_fridge/core/entities/recipe.dart';

abstract class RecipeGenerationRepository {
  Future<Recipe> generateRecipe(List<String> ingridients, String cuisine);
  Future<void> saveRecipe(Recipe recipe);
}
