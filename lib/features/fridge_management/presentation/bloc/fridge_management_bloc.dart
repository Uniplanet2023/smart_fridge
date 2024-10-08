import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';

import 'package:smart_fridge/features/fridge_management/domain/usecases/add_item_use_case.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/delete_item_use_case.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/edit_item_use_case.dart';
import 'package:smart_fridge/features/fridge_management/domain/usecases/fetch_items_use_case.dart';

part 'fridge_management_event.dart';
part 'fridge_management_state.dart';

class FridgeManagementBloc
    extends Bloc<FridgeManagementEvent, FridgeManagementState> {
  final AddItemUseCase addItemUseCase;
  final UpdateItemUseCase editItemUseCase;
  final DeleteItemUseCase deleteItemUseCase;
  final FetchItemsUseCase fetchItemsUseCase;
  FridgeManagementBloc({
    required this.addItemUseCase,
    required this.editItemUseCase,
    required this.deleteItemUseCase,
    required this.fetchItemsUseCase,
  }) : super(FridgeManagementInitial()) {
    on<LoadFridgeItemsEvent>(_onfetchItemsUseCase);
    on<AddFridgeItemEvent>(_onAddFridgeItemEvent);
    on<EditFridgeItemEvent>(_onEditItemUseCase);
    on<DeleteFridgeItemEvent>(_onDeleteItemUseCase);
  }

  Future<void> _onfetchItemsUseCase(
      LoadFridgeItemsEvent event, Emitter<FridgeManagementState> emit) async {
    emit(FridgeManagementLoading());
    try {
      final fridgeItems = await fetchItemsUseCase();
      if (fridgeItems!.isEmpty) {
        emit(FridgeManagementEmpty());
      } else {
        emit(FridgeManagementLoaded(fridgeItems));
      }
    } catch (e) {
      emit(FridgeManagementError(e.toString()));
    }
  }

  Future<void> _onAddFridgeItemEvent(
      AddFridgeItemEvent event, Emitter<FridgeManagementState> emit) async {
    emit(FridgeManagementAddingItem());
    try {
      await addItemUseCase(event.addedItem);
      emit(FridgeManagementItemAdded());
      add(LoadFridgeItemsEvent()); // Refetch items after adding
    } catch (e) {
      emit(const FridgeManagementError('Failed to add item'));
    }
  }

  Future<void> _onEditItemUseCase(
      EditFridgeItemEvent event, Emitter<FridgeManagementState> emit) async {
    emit(FridgeManagementEditingItem());
    try {
      await editItemUseCase(event.editedItem);
      emit(FridgeManagementItemEdited());
      add(LoadFridgeItemsEvent()); // Refetch items after adding
    } catch (e) {
      emit(const FridgeManagementError('Failed to edit item'));
    }
  }

  Future<void> _onDeleteItemUseCase(
      DeleteFridgeItemEvent event, Emitter<FridgeManagementState> emit) async {
    emit(FridgeManagementDeletingItem());
    try {
      await deleteItemUseCase(event.deletedItem);
      emit(FridgeManagementItemDeleted());
      add(LoadFridgeItemsEvent()); // Refetch items after adding
    } catch (e) {
      emit(const FridgeManagementError('Failed to delete item'));
    }
  }

  @override
  void onChange(Change<FridgeManagementState> change) {
    super.onChange(change);
    log(change.toString());
  }

  @override
  void onTransition(
      Transition<FridgeManagementEvent, FridgeManagementState> transition) {
    super.onTransition(transition);
    log(transition.toString());
  }
}
