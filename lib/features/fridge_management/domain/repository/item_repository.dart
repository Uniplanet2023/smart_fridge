import 'package:smart_fridge/core/domain_layer_entities/item.dart';

abstract class ItemRepository {
  Future<void> addItem(Item item);
  Future<void> deleteItem(Item item);
  Future<void> updateItem(Item item);
  Future<Item?> getItem(int id);
  Future<List<Item>> getAllItems();
}
