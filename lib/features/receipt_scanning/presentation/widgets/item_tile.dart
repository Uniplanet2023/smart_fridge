import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';

class ItemTile extends StatefulWidget {
  final Item item;
  final bool isChecked;
  final ValueChanged<bool?> onCheckboxChanged;
  final Function(Item) onEdit;
  final Function(Item) onDelete;
  final bool checkAll;

  const ItemTile({
    super.key,
    required this.item,
    required this.isChecked,
    required this.onCheckboxChanged,
    required this.onEdit,
    required this.onDelete,
    required this.checkAll,
  });

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  void didUpdateWidget(covariant ItemTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isChecked != widget.isChecked) {
      setState(() {
        isChecked = widget.isChecked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      visualDensity: VisualDensity.compact,
      leading: Checkbox(
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
          widget.onCheckboxChanged(value);
        },
      ),
      title: Text(
        widget.item.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Quantity: ',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
              children: <TextSpan>[
                TextSpan(
                  text: '${widget.item.quantity}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Expires on: ',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
              children: <TextSpan>[
                TextSpan(
                  text: DateFormat.yMMMd().format(widget.item.expiryDate),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ],
      ),
      trailing: PopupMenuButton<ListTileTitleAlignment>(
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<ListTileTitleAlignment>>[
          PopupMenuItem<ListTileTitleAlignment>(
            onTap: () => widget.onEdit(widget.item),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.edit),
                Text('Edit'),
              ],
            ),
          ),
          PopupMenuItem<ListTileTitleAlignment>(
            onTap: () => widget.onDelete(widget.item),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ),
                const Text('Remove'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
