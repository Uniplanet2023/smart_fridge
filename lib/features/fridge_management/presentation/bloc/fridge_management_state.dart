part of 'fridge_management_bloc.dart';

abstract class FridgeManagementState extends Equatable {
  const FridgeManagementState();

  @override
  List<Object?> get props => [];
}

class FridgeManagementInitial extends FridgeManagementState {}

class FridgeManagementLoading extends FridgeManagementState {}

class FridgeManagementLoaded extends FridgeManagementState {
  final List<Item> items;

  const FridgeManagementLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class FridgeManagementError extends FridgeManagementState {
  final String message;

  const FridgeManagementError(this.message);

  @override
  List<Object?> get props => [message];
}

class FridgeManagementAddingItem extends FridgeManagementState {}

class FridgeManagementEditingItem extends FridgeManagementState {}

class FridgeManagementDeletingItem extends FridgeManagementState {}

class FridgeManagementEmpty extends FridgeManagementState {}

class FridgeManagementItemAdded extends FridgeManagementState {}

class FridgeManagementItemEdited extends FridgeManagementState {}

class FridgeManagementItemDeleted extends FridgeManagementState {}
