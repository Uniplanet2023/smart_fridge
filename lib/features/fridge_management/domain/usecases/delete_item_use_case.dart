import 'package:smart_fridge/core/entities/item.dart';
import 'package:smart_fridge/features/fridge_management/domain/repository/fridge_management_repository.dart';

class DeleteItemUseCase {
  final FridgeManagementRepository repository;

  DeleteItemUseCase(this.repository);

  Future<void> call(Item item) async {
    await repository.deleteFridgeItem(item);
  }
}
