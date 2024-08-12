import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/core/domain_layer_entities/recipe.dart';
import 'package:smart_fridge/features/recipe_generation/presentation/bloc/bloc/recipe_generation_bloc.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late RecipeGenerationBloc recipeGenerationBloc;
  late MockGenerateRecipeUseCase mockGenerateRecipeUseCase;
  late MockSaveRecipeUseCase mockSaveRecipeUseCase;

  setUp(() {
    mockGenerateRecipeUseCase = MockGenerateRecipeUseCase();
    mockSaveRecipeUseCase = MockSaveRecipeUseCase();
    recipeGenerationBloc = RecipeGenerationBloc(
      generateRecipeUseCase: mockGenerateRecipeUseCase,
      saveRecipeUseCase: mockSaveRecipeUseCase,
    );
  });

  final testItems = [
    Item(
      id: 1,
      name: 'Chicken',
      quantity: 1,
      unitPrice: 10,
      totalPrice: 10,
      expiryDate: DateTime.now().add(const Duration(days: 2)),
    ),
    Item(
      id: 2,
      name: 'Rice',
      quantity: 2,
      unitPrice: 2,
      totalPrice: 4,
      expiryDate: DateTime.now().add(const Duration(days: 10)),
    ),
  ];

  final testRecipe = Recipe(
      name: 'Chicken and Rice',
      ingredients: [testItems[0], testItems[1]],
      instructions: ['Cook chicken', 'Cook rice', 'Mix together'],
      cuisine: 'Asian',
      shared: false);

  test('initial state should be RecipeGenerationInitial', () {
    expect(recipeGenerationBloc.state, equals(RecipeGenerationInitial()));
  });

  blocTest<RecipeGenerationBloc, RecipeGenerationState>(
    'emits [RecipeGenerating, RecipeGenerated] when recipe generation is successful',
    build: () {
      when(mockGenerateRecipeUseCase(any, any))
          .thenAnswer((_) async => [testRecipe]);
      return recipeGenerationBloc;
    },
    act: (bloc) =>
        bloc.add(GenerateRecipeEvent(ingredients: testItems, cuisine: 'Asian')),
    expect: () => [
      RecipeGenerating(),
      RecipeGenerated([testRecipe]),
    ],
    verify: (_) {
      verify(mockGenerateRecipeUseCase(testItems, 'Asian')).called(1);
    },
  );

  blocTest<RecipeGenerationBloc, RecipeGenerationState>(
    'emits [RecipeGenerating, RecipeGenerationError] when recipe generation fails',
    build: () {
      when(mockGenerateRecipeUseCase(any, any))
          .thenThrow(Exception('Generation Failed'));
      return recipeGenerationBloc;
    },
    act: (bloc) =>
        bloc.add(GenerateRecipeEvent(ingredients: testItems, cuisine: 'Asian')),
    expect: () => [
      RecipeGenerating(),
      isA<RecipeGenerationError>(),
    ],
  );

  blocTest<RecipeGenerationBloc, RecipeGenerationState>(
    'emits [RecipeSaving, RecipeSaved] when recipe saving is successful',
    build: () {
      when(mockSaveRecipeUseCase(any)).thenAnswer((_) async => {});
      return recipeGenerationBloc;
    },
    act: (bloc) => bloc.add(SaveRecipeEvent(testRecipe)),
    expect: () => [
      RecipeSaving(),
      RecipeSaved(),
    ],
    verify: (_) {
      verify(mockSaveRecipeUseCase(testRecipe)).called(1);
    },
  );

  blocTest<RecipeGenerationBloc, RecipeGenerationState>(
    'emits [RecipeSaving, RecipeGenerationError] when recipe saving fails',
    build: () {
      when(mockSaveRecipeUseCase(any)).thenThrow(Exception('Save Failed'));
      return recipeGenerationBloc;
    },
    act: (bloc) => bloc.add(SaveRecipeEvent(testRecipe)),
    expect: () => [
      RecipeSaving(),
      isA<RecipeGenerationError>(),
    ],
  );
}
