import 'package:smart_fridge/core/entities/item.dart';

abstract class FridgeManagementRepository {
  Future<List<Item>> fetchItems();
  Future<Item> addFridgeItem(Item item);
  Future<Item> editFridgeItem(Item item);
  Future<void> deleteFridgeItem(Item item);
}
