import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/bloc/read_receipt_bloc.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late ReadReceiptBloc readReceiptBloc;
  late MockReadReceiptUseCase mockReadReceiptUseCase;

  setUp(() {
    mockReadReceiptUseCase = MockReadReceiptUseCase();
    readReceiptBloc =
        ReadReceiptBloc(readReceiptUseCase: mockReadReceiptUseCase);
  });

  final testItems = [
    Item(
      id: 1,
      name: 'Milk',
      quantity: 1,
      unitPrice: 1.5,
      totalPrice: 1.5,
      expiryDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Item(
      id: 2,
      name: 'Bread',
      quantity: 2,
      unitPrice: 2.0,
      totalPrice: 4.0,
      expiryDate: DateTime.now().add(const Duration(days: 5)),
    ),
  ];

  final testImageFile = File('assets/images/trader-joes-receipt.png');

  test('initial state should be ReadReceiptInitial', () {
    expect(readReceiptBloc.state, equals(ReadReceiptInitial()));
  });

  blocTest<ReadReceiptBloc, ReadReceiptState>(
    'emits [ReadingReceipt, ReadReceiptCompleted] when receipt reading is successful',
    build: () {
      when(mockReadReceiptUseCase(any)).thenAnswer((_) async => testItems);
      return readReceiptBloc;
    },
    act: (bloc) => bloc.add(ScanReceiptEvent(testImageFile)),
    expect: () => [
      const ReadingReceipt(),
      ReadReceiptCompleted(receiptData: testItems),
    ],
  );

  blocTest<ReadReceiptBloc, ReadReceiptState>(
    'emits [ReadingReceipt, ReadReceiptError] when receipt reading fails',
    build: () {
      when(mockReadReceiptUseCase(any))
          .thenThrow(Exception('Failed to read receipt'));
      return readReceiptBloc;
    },
    act: (bloc) => bloc.add(ScanReceiptEvent(testImageFile)),
    expect: () => [
      const ReadingReceipt(),
      const ReadReceiptError(
        message:
            'There was an error while reading the receipt. Please ensure the image you uploaded is indeed a receipt, or try uploading it again.',
      ),
    ],
  );
}
