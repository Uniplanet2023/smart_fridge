import 'dart:convert';

import 'package:smart_fridge/core/entities/item.dart';
import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/core/helper/gemini_helper.dart';
import 'package:smart_fridge/core/prompt/generate_recipe.dart';

class RecipeRemoteDataSource {
  RecipeRemoteDataSource();

  Future<List<Recipe>> generateRecipe(
      List<Item> ingredients, String cuisine) async {
    try {
      // Call to Google Generative AI to generate recipe
      final prompt = generateRecipePrompt(ingredients, cuisine);

      final response = await GeminiHelper.instance.generateContent(prompt);
      if (response == null) {
        throw Exception("Failed to generate recipe");
      }

      final List<dynamic> jsonResult = jsonDecode(response) as List<dynamic>;
      final List<Recipe> results = jsonResult
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList();

      return results;
    } catch (e) {
      print(e);
    }
    return [];
  }
}
