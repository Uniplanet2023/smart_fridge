import 'package:isar/isar.dart';
import 'package:smart_fridge/features/recipe_generation/domain/repository/item_repository.dart';
import '../../domain/entities/item.dart';
import '../models/item_model.dart';

class ItemRepositoryImpl implements ItemRepository {
  final Isar isar;

  ItemRepositoryImpl(this.isar);

  @override
  Future<void> addItem(Item item) async {
    final itemModel = ItemModel.fromEntity(item);
    await isar.writeTxn(() async => await isar.itemModels.put(itemModel));
  }

  @override
  Future<List<Item>> getItems() async {
    final items = await isar.itemModels.where().findAll();
    return items.map((itemModel) => itemModel.toEntity()).toList();
  }
}
