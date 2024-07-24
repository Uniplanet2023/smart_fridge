import 'package:smart_fridge/core/entities/item.dart';
import 'package:smart_fridge/features/fridge_management/domain/repository/fridge_management_repository.dart';

class AddItemUseCase {
  final FridgeManagementRepository repository;

  AddItemUseCase(this.repository);

  Future<Item?> call(Item item) async {
    return await repository.addFridgeItem(item);
  }
}
