import 'package:isar/isar.dart';
import 'package:smart_fridge/features/recipes/domain/repository/recipe_repository.dart';

class DeleteRecipesUseCase {
  final RecipeRepository repository;

  DeleteRecipesUseCase(this.repository);

  Future<void> call(Id id) async {
    await repository.deleteSavedRecipe(id);
  }
}
