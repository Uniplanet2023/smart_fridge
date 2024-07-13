import 'dart:io';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:smart_fridge/core/helper/gemini_helper.dart';
import '../models/recipe_model.dart';

abstract class GeminiRemoteDataSource {
  Future<RecipeModel?> generateRecipe(String prompt);
  Future<String?> readReceipt(File receiptImage);
}

class RecipeRemoteDataSourceImpl implements GeminiRemoteDataSource {
  final Gemini gemini;

  RecipeRemoteDataSourceImpl(this.gemini);

  @override
  Future<RecipeModel?> generateRecipe(String prompt) async {
    final result = await gemini.text(prompt);
    if (result != null) {
      return RecipeModel(
        id: '', // Generate a unique ID
        name: 'Generated Recipe',
        description: result.output ?? '',
        instructions: result.output ?? '',
        timestamp: DateTime.now(),
        country: 'Unknown',
        shared: false,
      );
    }
    return null;
  }

  @override
  Future<String?> readReceipt(File receiptImage) async {
    try {
      final result = await GeminiHelper.instance
          .generateContentWithImage("Read this receipt", receiptImage);

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
