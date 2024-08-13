import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';

class EditItemDialog extends StatefulWidget {
  final Item item;
  final Function(Item) onSave;

  const EditItemDialog({super.key, required this.item, required this.onSave});

  @override
  EditItemDialogState createState() => EditItemDialogState();
}

class EditItemDialogState extends State<EditItemDialog> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item.name);
    quantityController =
        TextEditingController(text: widget.item.quantity.toString());
    dateController = TextEditingController(
        text: DateFormat.yMMMd().format(widget.item.expiryDate));
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Item Name'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: quantityController,
            decoration: const InputDecoration(labelText: 'Item Quantity'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: dateController,
            decoration: const InputDecoration(labelText: 'Expiry Date'),
            readOnly: true,
            onTap: () async {
              DateTime now = DateTime.now();
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDatePickerMode: DatePickerMode.day,
                initialDate: now,
                selectableDayPredicate: (day) {
                  if (day.isAfter(now.subtract(const Duration(days: 1))) ||
                      (day.year == widget.item.expiryDate.year &&
                          day.month == widget.item.expiryDate.month &&
                          day.day == widget.item.expiryDate.day)) {
                    return true;
                  }
                  return false;
                },
                firstDate: now.isBefore(widget.item.expiryDate)
                    ? now
                    : widget.item.expiryDate,
                lastDate: DateTime(2030),
              );
              if (pickedDate != null) {
                dateController.text = DateFormat.yMMMd().format(pickedDate);
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Use setState to create a new updated item
            setState(() {
              final updatedItem = widget.item.copyWith(
                name: nameController.text,
                quantity: double.parse(quantityController.text),
                expiryDate: DateFormat.yMMMd().parse(dateController.text),
              );
              widget.onSave(updatedItem);
            });
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
