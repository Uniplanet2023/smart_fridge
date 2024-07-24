part of 'fridge_management_bloc.dart';

sealed class FridgeManagementEvent extends Equatable {
  const FridgeManagementEvent();

  @override
  List<Object> get props => [];
}

class AddFridgeItemEvent extends FridgeManagementEvent {
  final Item addedItem;

  const AddFridgeItemEvent(this.addedItem);
}

class EditFridgeItemEvent extends FridgeManagementEvent {
  final Item editedItem;

  const EditFridgeItemEvent(this.editedItem);
}

class DeleteFridgeItemEvent extends FridgeManagementEvent {
  final Item deletedItem;

  const DeleteFridgeItemEvent(this.deletedItem);
}

class LoadFridgeItemsEvent extends FridgeManagementEvent {}
