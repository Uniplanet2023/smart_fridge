part of 'recipe_bloc.dart';

sealed class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class SearchRecipeStartedEvent extends RecipeEvent {
  final String searchQuery;

  const SearchRecipeStartedEvent(this.searchQuery);
}

class DeleteRecipeEvent extends RecipeEvent {
  final SaveRecipe recipe;

  const DeleteRecipeEvent(this.recipe);
}

class FetchRecipesEvent extends RecipeEvent {}
