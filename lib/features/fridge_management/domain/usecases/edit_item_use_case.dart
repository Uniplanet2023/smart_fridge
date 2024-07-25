import 'package:isar/isar.dart';
import 'package:smart_fridge/core/entities/item.dart';
import 'package:smart_fridge/features/fridge_management/domain/repository/item_repository.dart';

class UpdateItemUseCase {
  final ItemRepository repository;

  UpdateItemUseCase(this.repository);

  Future<void> call(Id id, Item item) async {
    return await repository.updateItem(id, item);
  }
}
