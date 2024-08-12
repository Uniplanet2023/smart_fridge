part of 'recipe_generation_bloc.dart';

sealed class RecipeGenerationEvent extends Equatable {
  const RecipeGenerationEvent();

  @override
  List<Object> get props => [];
}

class GenerateRecipeEvent extends RecipeGenerationEvent {
  final List<Item> ingredients;
  final String cuisine;

  const GenerateRecipeEvent({required this.ingredients, required this.cuisine});
}

class SaveRecipeEvent extends RecipeGenerationEvent {
  final Recipe recipe;

  const SaveRecipeEvent(this.recipe);
}
