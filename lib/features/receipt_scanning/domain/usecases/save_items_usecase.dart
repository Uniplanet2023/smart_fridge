import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/repository/item_repository.dart';

class SaveItemsUseCase {
  final ItemRepository repository;

  SaveItemsUseCase(this.repository);

  Future<void> call(List<Item> items) async {
    return await repository.saveItems(items);
  }
}
