import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/features/recipe_generation/data/models/recipe_model.dart';
import 'package:smart_fridge/features/recipes/domain/usecases/delete_recipes_use_case.dart';
import 'package:smart_fridge/features/recipes/domain/usecases/fetch_recipes_use_case.dart';
import 'package:smart_fridge/features/recipes/domain/usecases/search_recipes_use_case.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final DeleteRecipesUseCase deleteRecipesUseCase;
  final FetchRecipesUseCase fetchRecipesUseCase;
  final SearchRecipesUseCase searchRecipesUseCase;

  RecipeBloc({
    required this.fetchRecipesUseCase,
    required this.deleteRecipesUseCase,
    required this.searchRecipesUseCase,
  }) : super(RecipeInitial()) {
    on<FetchRecipesEvent>(_onFetchRecipesUseCase);
    on<DeleteRecipeEvent>(_onDeleteRecipesUseCase);
    on<SearchRecipeStartedEvent>(_onSearchRecipesUseCase);
  }

  Future<void> _onFetchRecipesUseCase(
      FetchRecipesEvent event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading());
    try {
      final recipes = await fetchRecipesUseCase();
      if (recipes.isEmpty) {
        emit(RecipeEmpty());
      } else {
        emit(RecipeLoaded(recipes));
      }
    } catch (e) {
      emit(const RecipeError('Failed to load recipes'));
    }
  }

  Future<void> _onDeleteRecipesUseCase(
      DeleteRecipeEvent event, Emitter<RecipeState> emit) async {
    emit(RecipeDeleting());
    try {
      await deleteRecipesUseCase(event.id);
      emit(RecipeDeletionSuccess());
      add(FetchRecipesEvent());
    } catch (e) {
      emit(const RecipeError('Failed to delete recipe'));
    }
  }

  Future<void> _onSearchRecipesUseCase(
      SearchRecipeStartedEvent event, Emitter<RecipeState> emit) async {
    emit(RecipeSearching());
    try {
      final searchResults = await searchRecipesUseCase(event.searchQuery);
      if (searchResults.isEmpty) {
        emit(RecipeSearchResultEmpty());
      } else {
        emit(RecipeSearchSuccess(searchResults));
      }
    } catch (e) {
      emit(const RecipeError('Error while searching'));
    }
  }
}
