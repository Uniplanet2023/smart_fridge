import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/fridge_management/presentation/bloc/fridge_management_bloc.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockAddItemUseCase mockAddItemUseCase;
  late MockDeleteItemUseCase mockDeleteItemUseCase;
  late MockFetchItemsUseCase mockFetchItemsUseCase;
  late MockUpdateItemUseCase mockUpdateItemUseCase;
  late FridgeManagementBloc fridgeManagementBloc;

  setUp(() {
    mockAddItemUseCase = MockAddItemUseCase();
    mockDeleteItemUseCase = MockDeleteItemUseCase();
    mockFetchItemsUseCase = MockFetchItemsUseCase();
    mockUpdateItemUseCase = MockUpdateItemUseCase();
    fridgeManagementBloc = FridgeManagementBloc(
      addItemUseCase: mockAddItemUseCase,
      deleteItemUseCase: mockDeleteItemUseCase,
      fetchItemsUseCase: mockFetchItemsUseCase,
      editItemUseCase: mockUpdateItemUseCase,
    );
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

  // test(
  //   'initial state should be FridgeManagementInitial',
  //   expect(fridgeManagementBloc.state, testItems)
  // );

  blocTest<FridgeManagementBloc, FridgeManagementState>(
    'emits [FridgeManagementLoading, FridgeManagementLoaded] when LoadFridgeItemsEvent is added and items are returned',
    build: () {
      when(mockFetchItemsUseCase()).thenAnswer((_) async => testItems);
      return fridgeManagementBloc;
    },
    act: (bloc) => bloc.add(LoadFridgeItemsEvent()),
    expect: () => [
      FridgeManagementLoading(),
      FridgeManagementLoaded(testItems),
    ],
  );

  blocTest<FridgeManagementBloc, FridgeManagementState>(
    'emits [FridgeManagementLoading, FridgeManagementEmpty] when LoadFridgeItemsEvent is added and no items are returned',
    build: () {
      when(mockFetchItemsUseCase()).thenAnswer((_) async => []);
      return fridgeManagementBloc;
    },
    act: (bloc) => bloc.add(LoadFridgeItemsEvent()),
    expect: () => [
      FridgeManagementLoading(),
      FridgeManagementEmpty(),
    ],
  );

  blocTest<FridgeManagementBloc, FridgeManagementState>(
    'emits [FridgeManagementAddingItem, FridgeManagementItemAdded, FridgeManagementLoading, FridgeManagementLoaded] when AddFridgeItemEvent is successful',
    build: () {
      when(mockAddItemUseCase(any)).thenAnswer((_) async => {});
      when(mockFetchItemsUseCase()).thenAnswer((_) async => testItems);
      return fridgeManagementBloc;
    },
    act: (bloc) => bloc.add(AddFridgeItemEvent(testItems.first)),
    expect: () => [
      FridgeManagementAddingItem(),
      FridgeManagementItemAdded(),
      FridgeManagementLoading(),
      FridgeManagementLoaded(testItems),
    ],
  );

  blocTest<FridgeManagementBloc, FridgeManagementState>(
    'emits [FridgeManagementEditingItem, FridgeManagementItemEdited, FridgeManagementLoading, FridgeManagementLoaded] when EditFridgeItemEvent is successful',
    build: () {
      when(mockUpdateItemUseCase(any)).thenAnswer((_) async => {});
      when(mockFetchItemsUseCase()).thenAnswer((_) async => testItems);
      return fridgeManagementBloc;
    },
    act: (bloc) => bloc.add(EditFridgeItemEvent(editedItem: testItems.first)),
    expect: () => [
      FridgeManagementEditingItem(),
      FridgeManagementItemEdited(),
      FridgeManagementLoading(),
      FridgeManagementLoaded(testItems),
    ],
  );

  blocTest<FridgeManagementBloc, FridgeManagementState>(
    'emits [FridgeManagementDeletingItem, FridgeManagementItemDeleted, FridgeManagementLoading, FridgeManagementLoaded] when DeleteFridgeItemEvent is successful',
    build: () {
      when(mockDeleteItemUseCase(any)).thenAnswer((_) async => {});
      when(mockFetchItemsUseCase()).thenAnswer((_) async => testItems);
      return fridgeManagementBloc;
    },
    act: (bloc) => bloc.add(DeleteFridgeItemEvent(testItems.first)),
    expect: () => [
      FridgeManagementDeletingItem(),
      FridgeManagementItemDeleted(),
      FridgeManagementLoading(),
      FridgeManagementLoaded(testItems),
    ],
  );
}
