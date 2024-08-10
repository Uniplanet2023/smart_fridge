// item_data_source.dart (in data/datasources)
import 'package:isar/isar.dart';
import 'package:smart_fridge/core/data_layer_models/item_model.dart';
import 'package:smart_fridge/core/helper/isar_helper.dart';

class ItemDataSource {
  final Isar isar = IsarHelper.isar;

  Future<void> addItem(ItemModel item) async {
    await isar.writeTxn(() async {
      await isar.itemModels.put(item);
    });
  }

  Future<void> deleteItem(ItemModel item) async {
    await isar.writeTxn(() async {
      await isar.itemModels.delete(item.id);
    });
  }

  Future<void> updateItem(ItemModel item) async {
    await isar.writeTxn(() async {
      final existingItem = await isar.itemModels.get(item.id);
      if (existingItem != null) {
        await isar.itemModels.put(item);
      } else {
        throw Exception('Item not found');
      }
    });
  }

  Future<ItemModel?> getItem(Id id) async {
    return await isar.itemModels.get(id);
  }

  Future<List<ItemModel>> getAllItems() async {
    return await isar.itemModels.where().findAll();
  }
}
