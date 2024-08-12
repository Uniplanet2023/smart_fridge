import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/delete_item_use_case.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late DeleteItemUseCase deleteItemUseCase;
  late MockItemRepository mockItemRepository;

  setUp(() {
    mockItemRepository = MockItemRepository();
    deleteItemUseCase = DeleteItemUseCase(mockItemRepository);
  });

  final testItem = Item(
    id: 1,
    name: 'Milk',
    quantity: 1,
    unitPrice: 0,
    totalPrice: 0,
    expiryDate: DateTime.now().add(const Duration(days: 3)),
  );

  test('Should delete item in Isar database', () async {
    // Arrange
    when(mockItemRepository.deleteItem(testItem)).thenAnswer((_) async {});

    // Act
    await deleteItemUseCase(testItem);

    // Assert
    verify(mockItemRepository.deleteItem(testItem)).called(1);
  });
}
