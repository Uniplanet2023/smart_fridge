part of 'item_list_bloc.dart';

abstract class ItemListEvent extends Equatable {
  const ItemListEvent();

  @override
  List<Object?> get props => [];
}

class SaveItemsEvent extends ItemListEvent {
  final List<Item> items;

  const SaveItemsEvent({required this.items});

  @override
  List<Object?> get props => [items];
}
