import '../../../../core/entities/item.dart';

abstract class ItemRepository {
  Future<void> saveItems(List<Item> items);
}
