// item_repository_impl.dart (in data/repositories)
import 'package:isar/isar.dart';
import 'package:smart_fridge/core/entities/item.dart';
import 'package:smart_fridge/features/fridge_management/data/data_sources/item_data_source.dart';
import 'package:smart_fridge/features/fridge_management/domain/repository/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemDataSource dataSource;

  ItemRepositoryImpl(this.dataSource);

  @override
  Future<void> addItem(Item item) => dataSource.addItem(item);

  @override
  Future<void> deleteItem(Id id) => dataSource.deleteItem(id);

  @override
  Future<void> updateItem(Id id, Item item) => dataSource.updateItem(id, item);

  @override
  Future<Item?> getItem(Id id) => dataSource.getItem(id);

  @override
  Future<List<Item>> getAllItems() => dataSource.getAllItems();
}
