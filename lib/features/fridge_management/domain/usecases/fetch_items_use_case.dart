import 'package:smart_fridge/core/entities/item.dart';
import 'package:smart_fridge/features/fridge_management/domain/repository/fridge_management_repository.dart';

class FetchItemsUseCase {
  final FridgeManagementRepository repository;

  FetchItemsUseCase(this.repository);

  Future<List<Item>?> call() async {
    return await repository.fetchItems();
  }
}
