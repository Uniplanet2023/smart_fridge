import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_fridge/core/data_layer_models/item_model.dart';
import 'package:smart_fridge/core/data_layer_models/recipe_model.dart';

import '../../helpers/json_reader.dart';

void main() {
  late RecipeModel testRecipeModel;

  setUp(() {
    final testItems = [
      ItemModel(
        id: 1,
        name: 'ingredient1_name',
        quantity: 1,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 3)),
      ),
      ItemModel(
        id: 2,
        name: 'ingredient2_name',
        quantity: 2,
        unitPrice: 1.5,
        totalPrice: 3.0,
        expiryDate: DateTime.now().add(const Duration(days: 5)),
      ),
    ];

    testRecipeModel = RecipeModel(
        name: "Recipe Name 1",
        cuisine: "cuisine type",
        instructions: ["Step 1: ...", "Step 2: ..."],
        ingredients: testItems,
        shared: false);
  });

  test('Should return a valid Recipe Model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_recipe_data.json'));

    // act
    final result = RecipeModel.fromJson(jsonMap);

    // Assert
    expect(result.name, testRecipeModel.name);
    expect(result.cuisine, testRecipeModel.cuisine);
    expect(result.instructions, testRecipeModel.instructions);
    expect(result.shared, testRecipeModel.shared);
  });
}
