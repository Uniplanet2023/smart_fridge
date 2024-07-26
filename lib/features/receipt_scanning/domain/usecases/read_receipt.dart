import 'dart:io';

import 'package:smart_fridge/features/receipt_scanning/domain/repository/gemini_repository.dart';

class ReadReceipt {
  final ReadReceiptRepository repository;

  ReadReceipt(this.repository);

  Future<String?> call(File receiptImage) async {
    return await repository.readReceipt(receiptImage);
  }
}
