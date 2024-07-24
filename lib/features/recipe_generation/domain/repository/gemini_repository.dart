import 'dart:io';

import 'package:smart_fridge/features/recipe_generation/domain/entities/recipe.dart';

abstract class ReadReceiptRepository {
  Future<Recipe?> generateRecipe(String prompt);
  Future<String?> readReceipt(File receiptImage);
}
