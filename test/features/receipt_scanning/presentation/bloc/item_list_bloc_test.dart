import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/bloc/item_list/item_list_bloc.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late ItemListBloc itemListBloc;
  late MockSaveItemsUseCase mockSaveItemsUseCase;

  setUp(() {
    mockSaveItemsUseCase = MockSaveItemsUseCase();
    itemListBloc = ItemListBloc(saveItemsUseCase: mockSaveItemsUseCase);
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

  test('initial state should be ItemListInitial', () {
    expect(itemListBloc.state, equals(ItemListInitial()));
  });

  blocTest<ItemListBloc, ItemListState>(
    'emits [SavingItemList, ItemListSaved] when items are saved successfully',
    build: () {
      when(mockSaveItemsUseCase(any)).thenAnswer((_) async => {});
      return itemListBloc;
    },
    act: (bloc) => bloc.add(SaveItemsEvent(items: testItems)),
    expect: () => [
      SavingItemList(),
      ItemListSaved(items: testItems),
    ],
    verify: (_) {
      verify(mockSaveItemsUseCase(testItems)).called(1);
    },
  );
}
