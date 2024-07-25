import 'package:isar/isar.dart';
import 'package:smart_fridge/core/entities/item.dart';

abstract class ItemRepository {
  Future<void> addItem(Item item);
  Future<void> deleteItem(Id id);
  Future<void> updateItem(Id id, Item item);
  Future<Item?> getItem(Id id);
  Future<List<Item>> getAllItems();
}
