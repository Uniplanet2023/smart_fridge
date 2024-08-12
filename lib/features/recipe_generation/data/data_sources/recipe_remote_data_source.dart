import 'dart:convert';

import 'package:smart_fridge/core/data_layer_models/recipe_model.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/core/domain_layer_entities/recipe.dart';
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
      // use data layer recipe model to change JSON result to appropriate recipe model
      final List<RecipeModel> results = jsonResult
          .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
          .toList();

      // convert to domain model before returning
      return results.map((recipe) => recipe.toDomain()).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
