import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/fridge_management/domain/repository/item_repository.dart';

class DeleteItemUseCase {
  final ItemRepository repository;

  DeleteItemUseCase(this.repository);

  Future<void> call(Item deletedItem) async {
    return await repository.deleteItem(deletedItem);
  }
}
