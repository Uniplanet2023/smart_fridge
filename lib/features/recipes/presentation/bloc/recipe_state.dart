part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object?> get props => [];
}

final class RecipeInitial extends RecipeState {}

final class RecipeSearching extends RecipeState {}

final class RecipeSearchSuccess extends RecipeState {
  final List<SaveRecipe> recipes;

  const RecipeSearchSuccess(this.recipes);

  @override
  List<Object?> get props => [recipes];
}

final class RecipeSearchResultEmpty extends RecipeState {}

final class RecipeLoading extends RecipeState {}

final class RecipeLoaded extends RecipeState {
  final List<SaveRecipe> recipes;

  const RecipeLoaded(this.recipes);

  @override
  List<Object?> get props => [recipes];
}

final class RecipeEmpty extends RecipeState {}

final class RecipeDeleting extends RecipeState {}

final class RecipeDeletionSuccess extends RecipeState {}

final class RecipeError extends RecipeState {
  final String message;

  const RecipeError(this.message);

  @override
  List<Object?> get props => [message];
}

final class RecipeUploading extends RecipeState {}

final class RecipeUploadSuccess extends RecipeState {}

final class RecipeUploadError extends RecipeState {
  final String message;

  const RecipeUploadError(this.message);

  @override
  List<Object?> get props => [message];
}
