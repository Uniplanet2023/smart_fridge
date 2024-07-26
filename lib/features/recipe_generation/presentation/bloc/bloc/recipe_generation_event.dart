part of 'recipe_generation_bloc.dart';

sealed class RecipeGenerationEvent extends Equatable {
  const RecipeGenerationEvent();

  @override
  List<Object> get props => [];
}

class GenerateRecipeEvent extends RecipeGenerationEvent {
  final List<String> ingridients;
  final String cuisine;

  const GenerateRecipeEvent(this.ingridients, this.cuisine);
}

class SaveRecipeEvent extends RecipeGenerationEvent {
  final Recipe recipe;

  const SaveRecipeEvent(this.recipe);
}
