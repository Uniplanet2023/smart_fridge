import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/add_item_use_case.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late AddItemUseCase addItemUseCase;
  late MockItemRepository mockItemRepository;

  setUp(() {
    mockItemRepository = MockItemRepository();
    addItemUseCase = AddItemUseCase(mockItemRepository);
  });

  final testItem = Item(
    name: 'Milk',
    quantity: 1,
    unitPrice: 0,
    totalPrice: 0,
    expiryDate: DateTime.now().add(const Duration(days: 3)),
  );

  test('Should add item in Isar database', () async {
    // Arrange
    when(mockItemRepository.addItem(testItem)).thenAnswer((_) async {});

    // Act
    await addItemUseCase(testItem);

    // Assert
    verify(mockItemRepository.addItem(testItem)).called(1);
  });
}
