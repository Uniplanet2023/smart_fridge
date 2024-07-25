import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_fridge/config/widgets/custom_textfield.dart';
import 'package:smart_fridge/core/entities/item.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/features/fridge_management/presentation/bloc/fridge_management_bloc.dart';

class EditFridgeItemsPage extends StatefulWidget {
  final Item item;
  const EditFridgeItemsPage({required this.item, super.key});

  @override
  State<EditFridgeItemsPage> createState() => _EditFridgeItemsPageState();
}

class _EditFridgeItemsPageState extends State<EditFridgeItemsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _itemNameController =
      TextEditingController(text: widget.item.name);
  late final TextEditingController _quantitycontroller =
      TextEditingController(text: widget.item.quantity.toString());

  late DateTime selectedDate = widget.item.expiryDate;

  @override
  void dispose() {
    _itemNameController.dispose();
    _quantitycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Edit item ",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Manually edit the information of a food item to ensure accuracy and completeness.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  controller: _itemNameController,
                  hintText: 'Item Name',
                  maxLength: 100,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  controller: _quantitycontroller,
                  hintText: 'Item Quantity',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Expected item expiry date',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${selectedDate.month.toString()}-${selectedDate.day.toString()}-${selectedDate.year.toString()}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: const Icon(Icons.calendar_month_outlined))
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        double itemQuantitiy =
                            (double.parse(_quantitycontroller.text.trim()) * 4)
                                    .round() /
                                4;
                        Item newItem = widget.item.copyWith(
                          name: _itemNameController.text.trim(),
                          quantity: itemQuantitiy,
                          expiryDate: selectedDate,
                        );
                        serviceLocator<FridgeManagementBloc>().add(
                            EditFridgeItemEvent(
                                editedItemId: widget.item.id,
                                editedItem: newItem));
                      }
                    },
                    child: Text(
                      'Edit',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select item expiry date',
      cancelText: 'Cancel',
      confirmText: 'Set',
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if (day.isAfter(DateTime.now().subtract(const Duration(days: 1)))) {
      return true;
    }
    return false;
  }
}
