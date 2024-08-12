import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/fridge_management/domain/repository/item_repository.dart';

class UpdateItemUseCase {
  final ItemRepository repository;

  UpdateItemUseCase(this.repository);

  Future<void> call(Item item) async {
    return await repository.updateItem(item);
  }
}
