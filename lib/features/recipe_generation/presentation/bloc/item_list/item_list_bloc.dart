import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_fridge/features/recipe_generation/domain/entities/item.dart';
import 'package:smart_fridge/features/recipe_generation/domain/usecases/save_items_usecase.dart';

part 'item_list_event.dart';
part 'item_list_state.dart';

class ItemListBloc extends Bloc<ItemListEvent, ItemListState> {
  final SaveItemsUseCase saveItemsUseCase;

  ItemListBloc({required this.saveItemsUseCase}) : super(ItemListInitial()) {
    on<SaveItemsEvent>((event, emit) async {
      emit(SavingItemList());
      await saveItemsUseCase(event.items);
      emit(ItemListSaved(items: event.items));
    });
  }
}
