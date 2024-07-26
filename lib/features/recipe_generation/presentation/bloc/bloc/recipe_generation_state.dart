part of 'recipe_generation_bloc.dart';

abstract class RecipeGenerationState extends Equatable {
  const RecipeGenerationState();

  @override
  List<Object?> get props => [];
}

final class RecipeGenerationInitial extends RecipeGenerationState {}

final class RecipeGenerating extends RecipeGenerationState {}

final class RecipeGenerated extends RecipeGenerationState {
  final Recipe recipe;

  const RecipeGenerated(this.recipe);

  @override
  List<Object?> get props => [recipe];
}

final class RecipeSaving extends RecipeGenerationState {}

final class RecipeNotFound extends RecipeGenerationState {}

final class RecipeSaved extends RecipeGenerationState {}

class RecipeGenerationError extends RecipeGenerationState {
  final String message;

  const RecipeGenerationError(this.message);

  @override
  List<Object?> get props => [message];
}
