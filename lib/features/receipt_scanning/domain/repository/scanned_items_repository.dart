import 'package:smart_fridge/core/domain_layer_entities/item.dart';

abstract class ScannedItemsRepository {
  Future<void> saveItems(List<Item> items);
}
