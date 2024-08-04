import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_fridge/core/isar_models/item.dart';

class AddItemDialog extends StatefulWidget {
  final Function(Item) onSave;

  const AddItemDialog({super.key, required this.onSave});

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    quantityController = TextEditingController();
    dateController = TextEditingController();
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
      title: const Text('Add Item'),
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
                  if (day.isAfter(now.subtract(const Duration(days: 1)))) {
                    return true;
                  }
                  return false;
                },
                firstDate: now,
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
            double itemQuantitiy =
                (double.parse(quantityController.text.trim()) * 4).round() / 4;
            final newItem = Item(
              name: nameController.text.trim(),
              quantity: itemQuantitiy,
              unitPrice: 1.0,
              totalPrice: 1.0,
              expiryDate: DateFormat.yMMMd().parse(dateController.text),
            );

            widget.onSave(newItem);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
