// item_data_source.dart (in data/datasources)
import 'package:isar/isar.dart';
import 'package:smart_fridge/core/entities/item.dart';
import 'package:smart_fridge/core/helper/isar_helper.dart';

class ItemDataSource {
  ItemDataSource();

  Future<void> addItem(Item item) async {
    await IsarHelper.isar.writeTxn(() async {
      await IsarHelper.isar.items.put(item);
    });
  }

  Future<void> deleteItem(Id id) async {
    await IsarHelper.isar.writeTxn(() async {
      await IsarHelper.isar.items.delete(id);
    });
  }

  Future<void> updateItem(Id id, Item item) async {
    await IsarHelper.isar.writeTxn(() async {
      // Check if the item exists
      final existingItem = await IsarHelper.isar.items.get(id);
      if (existingItem != null) {
        // Item exists, so update it
        existingItem.name = item.name;
        existingItem.quantity = item.quantity;
        existingItem.expiryDate = item.expiryDate;
        existingItem.totalPrice = item.totalPrice;
        existingItem.unitPrice = item.unitPrice;
        await IsarHelper.isar.items.put(existingItem);
      } else {
        throw Exception('Item not found');
      }
    });
  }

  Future<Item?> getItem(Id id) async {
    return await IsarHelper.isar.items.get(id);
  }

  Future<List<Item>> getAllItems() async {
    return await IsarHelper.isar.items.where().findAll();
  }
}
