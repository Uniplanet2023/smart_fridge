import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/fetch_items_use_case.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late FetchItemsUseCase fetchItemsUseCase;
  late MockItemRepository mockItemRepository;

  setUp(() {
    mockItemRepository = MockItemRepository();
    fetchItemsUseCase = FetchItemsUseCase(mockItemRepository);
  });

  final testItems = [
    Item(
      id: 1,
      name: 'Milk',
      quantity: 1,
      unitPrice: 0,
      totalPrice: 0,
      expiryDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Item(
      id: 2,
      name: 'Bread',
      quantity: 2,
      unitPrice: 1.5,
      totalPrice: 3.0,
      expiryDate: DateTime.now().add(const Duration(days: 5)),
    ),
  ];

  test('Should fetch a list of items from the Isar database', () async {
    // Arrange
    when(mockItemRepository.getAllItems()).thenAnswer((_) async => testItems);

    // Act
    final result = await fetchItemsUseCase();

    // Assert
    verify(mockItemRepository.getAllItems()).called(1);
    expect(result, equals(testItems));
  });
}
