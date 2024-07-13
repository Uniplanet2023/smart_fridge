import '../entities/item.dart';

abstract class ItemRepository {
  Future<void> addItem(Item item);
  Future<List<Item>> getItems();
}
