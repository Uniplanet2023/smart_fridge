import 'dart:io';

import 'package:smart_fridge/core/helper/gemini_helper.dart';
import 'package:smart_fridge/core/prompt/read_receipt.dart';
import '../models/recipe_model.dart';

abstract class ReadReceiptRemoteDataSource {
  Future<RecipeModel?> generateRecipe(String prompt);
  Future<String?> readReceipt(File receiptImage);
}

class RecipeRemoteDataSourceImpl implements ReadReceiptRemoteDataSource {
  RecipeRemoteDataSourceImpl();

  @override
  Future<RecipeModel?> generateRecipe(String prompt) async {
    final result = await GeminiHelper.instance.generateContent(prompt);
    if (result != null) {
      return RecipeModel(
        id: '', // Generate a unique ID
        name: 'Generated Recipe',
        description: result,
        instructions: result,
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
          .generateContentWithImage(readReceiptPromp, receiptImage);

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
