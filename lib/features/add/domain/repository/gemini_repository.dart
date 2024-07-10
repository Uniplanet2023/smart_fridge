import 'dart:io';

import 'package:smart_fridge/features/add/domain/entities/recipe.dart';

abstract class GeminiRepository {
  Future<Recipe?> generateRecipe(String prompt);
  Future<String?> readReceipt(File receiptImage);
}
