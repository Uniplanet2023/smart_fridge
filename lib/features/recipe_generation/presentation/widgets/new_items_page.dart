import 'package:flutter/material.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/features/recipe_generation/domain/entities/item.dart';
import 'package:smart_fridge/features/recipe_generation/presentation/bloc/item_list/item_list_bloc.dart';
import 'package:smart_fridge/features/recipe_generation/presentation/widgets/item_tile.dart';

class ItemListPage extends StatefulWidget {
  final List<Item> items;
  final Function(Item) onEdit;
  final Function(Item) onDelete;

  const ItemListPage({
    super.key,
    required this.items,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  ItemListPageState createState() => ItemListPageState();
}

class ItemListPageState extends State<ItemListPage> {
  late List<Item> items;

  @override
  void initState() {
    super.initState();
    items = widget.items;
  }

  void handleDelete(Item item) {
    setState(() {
      items.remove(item);
    });
  }

  void handleAdd() async {
    // TODO: Implement handleAdd
    // Add logic to add a new item
    // final newItem = Item(
    //   name: 'New Item',
    //   quantity: 1,
    //   unitPrice: 1.0,
    //   totalPrice: 1.0,
    //   expiryDate: DateTime.now().add(Duration(days: 7)),
    // );

    // setState(() {
    //   items.add(newItem);
    // });
  }

  void handleSave() {
    // Add logic to save the items
    // For example, you could save the items to a database or backend service
    print('Items saved: $items');
    serviceLocator<ItemListBloc>().add(SaveItemsEvent(items: items));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: handleAdd,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ItemTile(
            item: item,
            onEdit: widget.onEdit,
            onDelete: handleDelete,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleSave,
        tooltip: 'Save',
        child: const Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
