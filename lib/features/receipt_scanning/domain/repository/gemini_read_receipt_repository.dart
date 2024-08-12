import 'dart:io';

import 'package:smart_fridge/core/domain_layer_entities/item.dart';

abstract class ReadReceiptRepository {
  Future<List<Item>> readReceipt(File receiptImage);
}
