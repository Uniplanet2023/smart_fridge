import 'package:isar/isar.dart';
import 'package:smart_fridge/features/fridge_management/domain/repository/item_repository.dart';

class DeleteItemUseCase {
  final ItemRepository repository;

  DeleteItemUseCase(this.repository);

  Future<void> call(Id id) async {
    return await repository.deleteItem(id);
  }
}
