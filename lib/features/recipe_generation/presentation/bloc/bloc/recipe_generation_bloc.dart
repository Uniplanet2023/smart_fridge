import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/core/domain_layer_entities/recipe.dart';
import 'package:smart_fridge/features/recipe_generation/domain/usecases/generate_recipe_use_case.dart';
import 'package:smart_fridge/features/recipe_generation/domain/usecases/save_recipe_use_case.dart';


part 'recipe_generation_event.dart';
part 'recipe_generation_state.dart';

class RecipeGenerationBloc
    extends Bloc<RecipeGenerationEvent, RecipeGenerationState> {
  final GenerateRecipeUseCase generateRecipeUseCase;
  final SaveRecipeUseCase saveRecipeUseCase;
  RecipeGenerationBloc({
    required this.generateRecipeUseCase,
    required this.saveRecipeUseCase,
  }) : super(RecipeGenerationInitial()) {
    on<GenerateRecipeEvent>(_generateRecipeUseCase);
    on<SaveRecipeEvent>(_saveRecipeUseCase);
  }

  Future<void> _generateRecipeUseCase(
      GenerateRecipeEvent event, Emitter<RecipeGenerationState> emit) async {
    emit(RecipeGenerating());
    try {
      final generatedRecipe = await generateRecipeUseCase(
        event.ingredients,
        event.cuisine,
      );
      await saveRecipeUseCase(generatedRecipe.first);
      emit(RecipeGenerated(generatedRecipe));
    } catch (e) {
      emit(RecipeGenerationError(e.toString()));
    }
  }

  Future<void> _saveRecipeUseCase(
      SaveRecipeEvent event, Emitter<RecipeGenerationState> emit) async {
    emit(RecipeSaving());
    try {
      await saveRecipeUseCase(event.recipe);
      emit(RecipeSaved());
    } catch (e) {
      emit(RecipeGenerationError(e.toString()));
    }
  }
}
