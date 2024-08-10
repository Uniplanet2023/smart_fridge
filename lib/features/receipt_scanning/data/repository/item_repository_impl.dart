import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/core/helper/isar_helper.dart';
import 'package:smart_fridge/core/notification/schedule_notification.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/repository/item_repository.dart';
import '../../../../core/data_layer_models/item_model.dart';

class ItemRepositoryImpl implements ItemRepository {
  ItemRepositoryImpl();

  @override
  Future<void> saveItems(List<Item> items) async {
    List<ItemModel> itemsModel =
        items.map((item) => ItemModel.fromDomain(item)).toList();

    // Schedule notifications for the items
    scheduleNotificationForItems(itemsModel);

    // Save the items to the database
    await IsarHelper.isar.writeTxn(() async {
      await IsarHelper.isar.collection<ItemModel>().putAll(itemsModel);
    });
  }
}
