import 'dart:io';

import 'package:smart_fridge/features/recipe_generation/domain/repository/gemini_repository.dart';

class ReadReceipt {
  final ReadReceiptRepository repository;

  ReadReceipt(this.repository);

  Future<String?> call(File receiptImage) async {
    return await repository.readReceipt(receiptImage);
  }
}
