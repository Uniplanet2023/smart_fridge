import 'package:smart_fridge/core/isar_models/item.dart';
import 'package:smart_fridge/features/fridge_management/domain/repository/item_repository.dart';

class FetchItemsUseCase {
  final ItemRepository repository;

  FetchItemsUseCase(this.repository);

  Future<List<Item>?> call() async {
    return await repository.getAllItems();
  }
}
