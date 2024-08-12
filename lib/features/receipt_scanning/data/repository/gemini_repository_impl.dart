import 'dart:io';

import 'package:smart_fridge/core/data_layer_models/item_model.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/receipt_scanning/data/data_sources/gemini_data_source.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/repository/gemini_read_receipt_repository.dart';

class ReadReceiptRepositoryImpl implements ReadReceiptRepository {
  final ReadReceiptRemoteDataSource remoteDataSource;

  ReadReceiptRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Item>> readReceipt(File receiptImage) async {
    final List<ItemModel>? itemModels =
        await remoteDataSource.readReceipt(receiptImage);

    if (itemModels == null) {
      throw ReadReceiptException(
          'Error while reading the receipt: No items found.');
    }

    // Convert List<ItemModel> to List<Item>
    return itemModels.map((itemModel) => itemModel.toDomain()).toList();
  }
}
