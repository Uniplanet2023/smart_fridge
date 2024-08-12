import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/edit_item_use_case.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late UpdateItemUseCase updateItemUseCase;
  late MockItemRepository mockItemRepository;

  setUp(() {
    mockItemRepository = MockItemRepository();
    updateItemUseCase = UpdateItemUseCase(mockItemRepository);
  });

  final testItem = Item(
    id: 1,
    name: 'Milk',
    quantity: 1,
    unitPrice: 0,
    totalPrice: 0,
    expiryDate: DateTime.now().add(const Duration(days: 3)),
  );

  test('Should call updateItem on the repository with the correct item',
      () async {
    // Arrange
    when(mockItemRepository.updateItem(testItem)).thenAnswer((_) async => {});

    // Act
    await updateItemUseCase(testItem);

    // Assert
    verify(mockItemRepository.updateItem(testItem)).called(1);
  });
}
