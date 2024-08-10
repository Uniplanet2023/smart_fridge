import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_fridge/features/home/data/models/shared_recipe.dart';
import 'package:smart_fridge/features/home/domain/usecases/delete_recipe_use_case.dart';
import 'package:smart_fridge/features/home/domain/usecases/fetch_recipes_use_case.dart';
import 'package:smart_fridge/features/home/domain/usecases/like_recipe_use_case.dart';
import 'package:smart_fridge/features/home/domain/usecases/update_recipe_use_case.dart';

part 'shared_recipe_event.dart';
part 'shared_recipe_state.dart';

class SharedRecipeBloc extends Bloc<SharedRecipeEvent, SharedRecipeState> {
  final FetchSharedRecipesUseCase fetchSharedRecipeUseCase;
  final DeleteSharedRecipeUseCase deleteSharedRecipeUseCase;
  final UpdateSharedRecipeUseCase updateSharedRecipeUseCase;
  final LikeSharedRecipeUseCase likeRecipeUseCase;

  SharedRecipeBloc({
    required this.fetchSharedRecipeUseCase,
    required this.deleteSharedRecipeUseCase,
    required this.updateSharedRecipeUseCase,
    required this.likeRecipeUseCase,
  }) : super(SharedRecipeInitial()) {
    on<SharedRecipeEvent>((event, emit) {
      on<FetchSharedRecipesEvent>(_onFetchRecipesEvent);
      on<DeleteSharedRecipeEvent>(_onDeleteRecipeEvent);
      on<UpdateSharedRecipeEvent>(_onUpdateRecipeEvent);
      on<LikeSharedRecipeEvent>(_onLikeRecipeEvent);
    });
  }

  Future<void> _onLikeRecipeEvent(
      LikeSharedRecipeEvent event, Emitter<SharedRecipeState> emit) async {
    try {
      await likeRecipeUseCase(event.recipeId, event.userId);
    } catch (e) {
      emit(const SharedRecipeError('Failed to like recipe'));
    }
  }

  Future<void> _onFetchRecipesEvent(
      FetchSharedRecipesEvent event, Emitter<SharedRecipeState> emit) async {
    emit(RecipeLoading());
    try {
      final recipes = await fetchSharedRecipeUseCase();
      emit(RecipeLoaded(recipes));
    } catch (e) {
      emit(const RecipeError('Failed to load recipes'));
    }
  }

  Future<void> _onDeleteRecipeEvent(
      DeleteSharedRecipeEvent event, Emitter<SharedRecipeState> emit) async {
    try {
      await deleteSharedRecipeUseCase(event.recipeId);
      emit(SharedRecipeDeletionSuccess());
      add(FetchSharedRecipesEvent());
    } catch (e) {
      emit(const SharedRecipeError('Failed to delete recipe'));
    }
  }

  Future<void> _onUpdateRecipeEvent(
      UpdateSharedRecipeEvent event, Emitter<SharedRecipeState> emit) async {
    try {
      await updateSharedRecipeUseCase(event.recipe);
      emit(SharedRecipeUpdateSuccess());
    } catch (e) {
      emit(const SharedRecipeError('Failed to update recipe'));
    }
  }
}
