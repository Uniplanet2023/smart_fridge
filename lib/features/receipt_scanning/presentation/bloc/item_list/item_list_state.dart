part of 'item_list_bloc.dart';

abstract class ItemListState extends Equatable {
  const ItemListState();

  @override
  List<Object?> get props => [];
}

class ItemListInitial extends ItemListState {}

class SavingItemList extends ItemListState {}

class ItemListLoaded extends ItemListState {
  final List<Item> items;

  const ItemListLoaded({required this.items});

  @override
  List<Object?> get props => [items];
}

class ItemListSaved extends ItemListState {
  final List<Item> items;

  const ItemListSaved({required this.items});

  @override
  List<Object?> get props => [items];
}
