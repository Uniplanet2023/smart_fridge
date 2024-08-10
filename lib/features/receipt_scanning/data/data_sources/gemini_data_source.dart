import 'dart:convert';
import 'dart:io';

import 'package:smart_fridge/core/data_layer_models/item_model.dart';
import 'package:smart_fridge/core/helper/gemini_helper.dart';
import 'package:smart_fridge/core/prompt/read_receipt.dart';

abstract class ReadReceiptRemoteDataSource {
  Future<List<ItemModel>?> readReceipt(File receiptImage);
}

class RecipeRemoteDataSourceImpl implements ReadReceiptRemoteDataSource {
  RecipeRemoteDataSourceImpl();

  @override
  Future<List<ItemModel>> readReceipt(File receiptImage) async {
    try {
      final String? result = await GeminiHelper.instance
          .generateContentWithImage(readReceiptPromp, receiptImage);
      // Clean the JSON string if it contains unwanted text

      if (result == null) {
        throw ReadReceiptException(
            'Error while reading the receipt: Please ensure the image you uploaded is indeed a receipt.');
      }

      // Parse JSON data
      final List<dynamic> parsedJson = jsonDecode(result);

      return parsedJson
          .map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ReadReceiptException(e.toString());
    }
  }
}

class ReadReceiptException implements Exception {
  final String message;
  ReadReceiptException(this.message);

  @override
  String toString() => message;
}
