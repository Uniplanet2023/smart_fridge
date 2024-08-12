part of 'shared_recipe_bloc.dart';

sealed class SharedRecipeState extends Equatable {
  const SharedRecipeState();

  @override
  List<Object> get props => [];
}

final class SharedRecipeInitial extends SharedRecipeState {}

final class SharedRecipeLoading extends SharedRecipeState {}

final class SharedRecipeLoaded extends SharedRecipeState {
  final List<SharedRecipe> recipes;

  const SharedRecipeLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

final class RecipeError extends SharedRecipeState {
  final String message;

  const RecipeError(this.message);

  @override
  List<Object> get props => [message];
}

final class SharedRecipeDeletionSuccess extends SharedRecipeState {}

final class SharedRecipeUpdateSuccess extends SharedRecipeState {}

final class SharedRecipeError extends SharedRecipeState {
  final String message;

  const SharedRecipeError(this.message);

  @override
  List<Object> get props => [message];
}
