import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/usecases/read_receipt_use_case.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late ReadReceiptUseCase readReceiptUseCase;
  late MockReadReceiptRepository mockReadReceiptRepository;

  setUp(() {
    mockReadReceiptRepository = MockReadReceiptRepository();
    readReceiptUseCase = ReadReceiptUseCase(mockReadReceiptRepository);
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

  File testImage = File('assets/images/trader-joes-receipt.png');

  test('Should return a list of items after reading receipt', () async {
    // Arrange
    when(mockReadReceiptRepository.readReceipt(any))
        .thenAnswer((_) async => testItems);

    // Act
    final result =
        await readReceiptUseCase(testImage); // Pass the image or mock input

    // Assert
    verify(mockReadReceiptRepository.readReceipt(testImage)).called(1);
    expect(result, equals(testItems));
  });
}
