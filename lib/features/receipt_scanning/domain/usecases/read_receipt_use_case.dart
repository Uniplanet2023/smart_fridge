import 'dart:io';

import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/repository/gemini_read_receipt_repository.dart';

class ReadReceiptUseCase {
  final ReadReceiptRepository repository;

  ReadReceiptUseCase(this.repository);

  Future<List<Item>> call(File receiptImage) async {
    return await repository.readReceipt(receiptImage);
  }
}
