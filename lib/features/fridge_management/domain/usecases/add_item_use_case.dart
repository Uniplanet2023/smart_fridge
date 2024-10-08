import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/fridge_management/domain/repository/item_repository.dart';

class AddItemUseCase {
  final ItemRepository repository;

  AddItemUseCase(this.repository);

  Future<void> call(Item item) async {
    return await repository.addItem(item);
  }
}
