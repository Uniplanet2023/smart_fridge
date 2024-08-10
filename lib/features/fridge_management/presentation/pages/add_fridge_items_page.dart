import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_fridge/config/widgets/custom_textfield.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/features/fridge_management/presentation/bloc/fridge_management_bloc.dart';

class AddFridgeItemsPage extends StatefulWidget {
  const AddFridgeItemsPage({super.key});

  @override
  State<AddFridgeItemsPage> createState() => _AddFridgeItemsPageState();
}

class _AddFridgeItemsPageState extends State<AddFridgeItemsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantitycontroller = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    _itemNameController.dispose();
    _quantitycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FridgeManagementBloc, FridgeManagementState>(
      listener: (context, state) {
        if (state is FridgeManagementItemAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              content: Text(
                "Item Added!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ),
          );
        } else if (state is FridgeManagementError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              content: Text(
                "Error while adding item!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ),
          );
        }
      },
      child: Scaffold(
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
                    "Add an item ",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Manually enter a food item missed by the receipt scanner or one you want to add individually.',
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
                        double itemQuantitiy =
                            (double.parse(_quantitycontroller.text.trim()) * 4)
                                    .round() /
                                4;
                        if (_formKey.currentState!.validate()) {
                          context.read<FridgeManagementBloc>().add(
                                AddFridgeItemEvent(
                                  Item(
                                      name: _itemNameController.text.trim(),
                                      quantity: itemQuantitiy,
                                      unitPrice: 0,
                                      totalPrice: 0,
                                      expiryDate: selectedDate),
                                ),
                              );
                        }
                      },
                      child: Text(
                        'Add',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ),
                ],
              ),
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
