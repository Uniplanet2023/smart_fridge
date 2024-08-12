import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/repository/scanned_items_repository.dart';

class SaveItemsUseCase {
  final ScannedItemsRepository repository;

  SaveItemsUseCase(this.repository);

  Future<void> call(List<Item> items) async {
    return await repository.saveItems(items);
  }
}
