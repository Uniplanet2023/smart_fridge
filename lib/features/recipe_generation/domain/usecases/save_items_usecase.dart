import 'package:smart_fridge/features/recipe_generation/domain/repository/item_repository.dart';

import '../../../../core/entities/item.dart';

class SaveItemsUseCase {
  final ItemRepository repository;

  SaveItemsUseCase(this.repository);

  Future<void> call(List<Item> items) async {
    return await repository.saveItems(items);
  }
}
