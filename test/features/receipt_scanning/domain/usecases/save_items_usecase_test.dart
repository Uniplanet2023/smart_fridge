import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/usecases/save_items_usecase.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveItemsUseCase saveItemsUseCase;
  late MockScannedItemsRepository mockScannedItemsRepository;

  setUp(() {
    mockScannedItemsRepository = MockScannedItemsRepository();
    saveItemsUseCase = SaveItemsUseCase(mockScannedItemsRepository);
  });

  final testItems = [
    Item(
      name: 'Milk',
      quantity: 1,
      unitPrice: 0,
      totalPrice: 0,
      expiryDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Item(
      name: 'Bread',
      quantity: 2,
      unitPrice: 1.5,
      totalPrice: 3.0,
      expiryDate: DateTime.now().add(const Duration(days: 5)),
    ),
  ];

  test(
      'Should call save Items in ItemRepositoryImpl to save a list of items to Isar database after reading receipt',
      () async {
    // Arrange
    when(mockScannedItemsRepository.saveItems(testItems))
        .thenAnswer((_) async => {});

    // Act
    await saveItemsUseCase(testItems);

    // Assert
    verify(mockScannedItemsRepository.saveItems(testItems)).called(1);
  });
}
