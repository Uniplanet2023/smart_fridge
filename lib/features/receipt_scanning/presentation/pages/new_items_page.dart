import 'package:flutter/material.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/core/entities/item.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/bloc/item_list/item_list_bloc.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/widgets/edit_item_dialog.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/widgets/add_item_dialog.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/widgets/item_tile.dart';

class ItemListPage extends StatefulWidget {
  final List<Item> items;

  const ItemListPage({
    super.key,
    required this.items,
  });

  @override
  ItemListPageState createState() => ItemListPageState();
}

class ItemListPageState extends State<ItemListPage> {
  late List<Item> items;
  bool checkAll = false;
  late List<bool> itemCheckedStatus;

  @override
  void initState() {
    super.initState();
    // Ensure items is a modifiable list
    items = widget.items.toList();
    itemCheckedStatus = List<bool>.filled(items.length, false).toList();
  }

  void handleDelete(Item item) {
    setState(() {
      int index = items.indexOf(item);
      if (index != -1) {
        items.removeAt(index);
        itemCheckedStatus.removeAt(index);
        // Update the checkAll status
        checkAll = itemCheckedStatus.isNotEmpty &&
            itemCheckedStatus.every((element) => element);
      }
    });
  }

  void handleEdit(Item item) {
    showDialog(
      context: context,
      builder: (context) => EditItemDialog(
        item: item,
        onSave: (updatedItem) {
          setState(() {
            int index = items.indexOf(item);
            items[index] = updatedItem;
          });
        },
      ),
    );
  }

  void handleAdd() async {
    showDialog(
      context: context,
      builder: (context) => AddItemDialog(
        onSave: (newItem) {
          setState(() {
            items.add(newItem);
            itemCheckedStatus.add(false);
          });
        },
      ),
    );
  }

  void handleSave() {
    final selectedItems = items
        .asMap()
        .entries
        .where((entry) => itemCheckedStatus[entry.key])
        .map((entry) => entry.value)
        .toList();
    print('Selected Items saved: $selectedItems');
    serviceLocator<ItemListBloc>().add(SaveItemsEvent(items: selectedItems));

    serviceLocator<ItemListBloc>().stream.listen((state) {
      if (state is ItemListSaved) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            content: Text(
              'Successfully added Items',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inverseSurface),
            ),
          ),
        );
      }
    });
  }

  void toggleSelectAll(bool? value) {
    setState(() {
      checkAll = value ?? false;
      for (int i = 0; i < itemCheckedStatus.length; i++) {
        itemCheckedStatus[i] = checkAll;
      }
    });
  }

  void toggleItemSelection(int index, bool? isChecked) {
    setState(() {
      itemCheckedStatus[index] = isChecked ?? false;
    });
  }

  bool get isAnyItemSelected {
    return itemCheckedStatus.any((isChecked) => isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Item List',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: handleAdd,
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: checkAll,
                onChanged: toggleSelectAll,
              ),
              Text(
                'Select All',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ItemTile(
                  item: item,
                  isChecked: itemCheckedStatus[index],
                  onCheckboxChanged: (isChecked) =>
                      toggleItemSelection(index, isChecked),
                  onEdit: handleEdit,
                  onDelete: handleDelete,
                  checkAll: checkAll,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: isAnyItemSelected,
        child: FloatingActionButton(
          onPressed: handleSave,
          tooltip: 'Save',
          child: const Icon(Icons.save),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
