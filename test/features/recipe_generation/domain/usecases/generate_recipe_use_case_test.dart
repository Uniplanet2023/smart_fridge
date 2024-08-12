import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/core/domain_layer_entities/recipe.dart';
import 'package:smart_fridge/features/recipe_generation/domain/usecases/generate_recipe_use_case.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GenerateRecipeUseCase generateRecipeUseCase;
  late MockRecipeRepository mockRecipeRepository;

  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    generateRecipeUseCase = GenerateRecipeUseCase(mockRecipeRepository);
  });

  final testItems = [
    Item(
      id: 1,
      name: 'Milk',
      quantity: 1,
      unitPrice: 0,
      totalPrice: 0,
      expiryDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Item(
      id: 2,
      name: 'Bread',
      quantity: 2,
      unitPrice: 1.5,
      totalPrice: 3.0,
      expiryDate: DateTime.now().add(const Duration(days: 5)),
    ),
  ];
  const testCuisine = 'Italian';

  final testRecipes = [
    Recipe(
        name: 'Recipe 1',
        cuisine: "Italian cuisine",
        instructions: ['instruction 1', 'instruction 2', 'instruction 3'],
        ingredients: [testItems[0], testItems[1]],
        shared: false),
    Recipe(
        name: 'Recipe 2',
        cuisine: "Italian cuisine",
        instructions: ['instruction 1', 'instruction 2', 'instruction 3'],
        ingredients: [testItems[0], testItems[1]],
        shared: false),
  ];

  test('Should return a list of generated recipes', () async {
    // Arrange
    when(mockRecipeRepository.generateRecipe(testItems, testCuisine))
        .thenAnswer((_) async {
      return testRecipes;
    });

    // Act
    final result = await generateRecipeUseCase(testItems, testCuisine);

    // Assert
    verify(mockRecipeRepository.generateRecipe(testItems, testCuisine))
        .called(1);
    expect(result, equals(testRecipes));
  });
}
