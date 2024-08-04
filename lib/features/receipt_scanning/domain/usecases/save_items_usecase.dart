import 'package:smart_fridge/features/receipt_scanning/domain/repository/item_repository.dart';

import '../../../../core/isar_models/item.dart';

class SaveItemsUseCase {
  final ItemRepository repository;

  SaveItemsUseCase(this.repository);

  Future<void> call(List<Item> items) async {
    return await repository.saveItems(items);
  }
}
