part of 'shared_recipe_bloc.dart';

sealed class SharedRecipeEvent extends Equatable {
  const SharedRecipeEvent();

  @override
  List<Object> get props => [];
}

class FetchSharedRecipesEvent extends SharedRecipeEvent {}

class DeleteSharedRecipeEvent extends SharedRecipeEvent {
  final String recipeId;

  const DeleteSharedRecipeEvent(this.recipeId);

  @override
  List<Object> get props => [recipeId];
}

class UpdateSharedRecipeEvent extends SharedRecipeEvent {
  final SharedRecipe recipe;

  const UpdateSharedRecipeEvent(this.recipe);

  @override
  List<Object> get props => [recipe];
}

class LikeSharedRecipeEvent extends SharedRecipeEvent {
  final String recipeId;
  final String userId;

  const LikeSharedRecipeEvent(this.recipeId, this.userId);

  @override
  List<Object> get props => [recipeId, userId];
}
