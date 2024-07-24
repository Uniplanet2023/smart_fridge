import 'package:smart_fridge/features/recipe_generation/domain/repository/gemini_repository.dart';
import '../entities/recipe.dart';

class GenerateRecipe {
  final ReadReceiptRepository repository;

  GenerateRecipe(this.repository);

  Future<Recipe?> call(String prompt) {
    return repository.generateRecipe(prompt);
  }
}
