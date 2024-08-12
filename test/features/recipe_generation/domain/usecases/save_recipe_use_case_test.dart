import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/core/domain_layer_entities/recipe.dart';
import 'package:smart_fridge/features/recipe_generation/domain/usecases/save_recipe_use_case.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveRecipeUseCase saveRecipeUseCase;
  late MockRecipeRepository mockRecipeRepository;

  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    saveRecipeUseCase = SaveRecipeUseCase(mockRecipeRepository);
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

  final testRecipe = Recipe(
      name: 'Recipe 1',
      cuisine: "Italian cuisine",
      instructions: ['instruction 1', 'instruction 2', 'instruction 3'],
      ingredients: [testItems[0], testItems[1]],
      shared: false);

  test('Should save recipe in Isar database', () async {
    // Arrange
    when(mockRecipeRepository.saveRecipe(testRecipe)).thenAnswer((_) async {});

    // Act
    await saveRecipeUseCase(testRecipe);

    // Assert
    verify(mockRecipeRepository.saveRecipe(testRecipe)).called(1);
  });
}
