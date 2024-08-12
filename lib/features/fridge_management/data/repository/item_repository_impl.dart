import 'package:smart_fridge/core/domain_layer_entities/item.dart'; // Domain model
import 'package:smart_fridge/core/data_layer_models/item_model.dart'; // Data model
import 'package:smart_fridge/features/fridge_management/data/data_sources/item_data_source.dart';
import 'package:smart_fridge/features/fridge_management/domain/repository/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemDataSource dataSource;

  ItemRepositoryImpl(this.dataSource);

  @override
  Future<void> addItem(Item item) async {
    final itemModel = ItemModel.fromDomain(item);
    await dataSource.addItem(itemModel);
  }

  @override
  Future<void> deleteItem(Item item) async {
    final itemModel = ItemModel.fromDomain(item);
    await dataSource.deleteItem(itemModel);
  }

  @override
  Future<void> updateItem(Item item) async {
    final itemModel = ItemModel.fromDomain(item);

    await dataSource.updateItem(itemModel);
  }

  @override
  Future<Item?> getItem(int id) async {
    final itemModel = await dataSource.getItem(id);
    return itemModel?.toDomain();
  }

  @override
  Future<List<Item>> getAllItems() async {
    final itemModels = await dataSource.getAllItems();
    return itemModels.map((model) => model.toDomain()).toList();
  }
}
