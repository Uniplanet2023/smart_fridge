import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_fridge/features/recipe_generation/domain/entities/item.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  final Item item;
  final Function(Item) onEdit;
  final Function(Item) onDelete;

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
      title: Text(widget.item.name),
      subtitle: Text('Quantity: ${widget.item.quantity}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Expires ${DateFormat.yMMMd().format(widget.item.expiryDate)}',
            style: TextStyle(
              color: widget.item.expiryDate.isBefore(DateTime.now())
                  ? Colors.red
                  : Colors.black,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => widget.onEdit(widget.item),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => widget.onDelete(widget.item),
          ),
        ],
      ),
    );
  }
}
