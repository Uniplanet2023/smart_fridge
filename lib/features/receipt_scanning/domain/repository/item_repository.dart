import '../../../../core/isar_models/item.dart';

abstract class ItemRepository {
  Future<void> saveItems(List<Item> items);
}
