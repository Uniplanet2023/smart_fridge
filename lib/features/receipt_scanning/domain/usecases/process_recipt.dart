import 'dart:typed_data';
import 'dart:convert';
import 'package:smart_fridge/features/receipt_scanning/domain/repository/item_repository.dart';

class ProcessReceipt {
  final ItemRepository repository;

  ProcessReceipt(this.repository);

  Future<void> call(Uint8List receiptImage) async {}

  List<Map<String, dynamic>> parseReceiptData(String? receiptData) {
    if (receiptData == null || receiptData.isEmpty) {
      throw Exception('Invalid receipt data');
    }
    final data = jsonDecode(receiptData);
    return List<Map<String, dynamic>>.from(data['items']);
  }
}
