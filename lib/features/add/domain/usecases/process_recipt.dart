import 'dart:typed_data';
import 'dart:convert';
import 'package:smart_fridge/features/add/domain/repository/item_repository.dart';

import '../entities/item.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ProcessReceipt {
  final ItemRepository repository;

  ProcessReceipt(this.repository);

  Future<void> call(Uint8List receiptImage) async {
    final gemini = Gemini.instance;

    try {
      // Get the receipt data from Gemini
      final receiptData = await gemini.textAndImage(
        text:
            "Extract items from this receipt. Please return the data in JSON format.",
        images: [receiptImage],
      );

      // Convert the receipt data to JSON format and extract items
      final itemsJson =
          parseReceiptData(receiptData?.content?.parts?.last.text);
      final items = itemsJson.map<Item>((json) => Item.fromJson(json)).toList();

      // Save items to Isar
      for (var item in items) {
        await repository.addItem(item);
      }
    } catch (e) {
      rethrow;
    }
  }

  List<Map<String, dynamic>> parseReceiptData(String? receiptData) {
    if (receiptData == null || receiptData.isEmpty) {
      throw Exception('Invalid receipt data');
    }
    final data = jsonDecode(receiptData);
    return List<Map<String, dynamic>>.from(data['items']);
  }
}
