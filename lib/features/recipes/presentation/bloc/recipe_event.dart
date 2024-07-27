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
  final Id id;

  const DeleteRecipeEvent(this.id);
}

class FetchRecipesEvent extends RecipeEvent {}
