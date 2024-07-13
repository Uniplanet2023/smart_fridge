import 'dart:io';

import 'package:smart_fridge/features/add/domain/repository/gemini_repository.dart';

class ReadReceipt {
  final GeminiRepository repository;

  ReadReceipt(this.repository);

  Future<String?> call(File receiptImage) async {
    return await repository.readReceipt(receiptImage);
  }
}
