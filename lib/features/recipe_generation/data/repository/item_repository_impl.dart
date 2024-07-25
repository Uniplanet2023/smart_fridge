import 'package:smart_fridge/core/helper/isar_helper.dart';
import 'package:smart_fridge/features/recipe_generation/domain/repository/item_repository.dart';
import '../../../../core/entities/item.dart';

class ItemRepositoryImpl implements ItemRepository {
  ItemRepositoryImpl();

  @override
  Future<void> saveItems(List<Item> items) async {
    await IsarHelper.isar.writeTxn(() async {
      await IsarHelper.isar.collection<Item>().putAll(items);
    });
  }
}
