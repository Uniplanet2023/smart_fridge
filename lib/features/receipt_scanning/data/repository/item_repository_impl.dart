import 'package:smart_fridge/core/helper/isar_helper.dart';
import 'package:smart_fridge/core/notification/schedule_notification.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/repository/item_repository.dart';
import '../../../../core/isar_models/item.dart';

class ItemRepositoryImpl implements ItemRepository {
  ItemRepositoryImpl();

  @override
  Future<void> saveItems(List<Item> items) async {
    // Schedule notifications for the items
    scheduleNotificationForItems(items);
    // Save the items to the database
    await IsarHelper.isar.writeTxn(() async {
      await IsarHelper.isar.collection<Item>().putAll(items);
    });
  }
}
