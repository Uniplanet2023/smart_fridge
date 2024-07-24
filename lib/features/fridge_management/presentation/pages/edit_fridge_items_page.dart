import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_fridge/config/widgets/custom_textfield.dart';

class EditFridgeItemsPage extends StatefulWidget {
  const EditFridgeItemsPage({super.key});

  @override
  State<EditFridgeItemsPage> createState() => _EditFridgeItemsPageState();
}

class _EditFridgeItemsPageState extends State<EditFridgeItemsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantitycontroller = TextEditingController();
  final TextEditingController _expiryDatecontroller = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    _itemNameController.dispose();
    _quantitycontroller.dispose();
    _expiryDatecontroller.dispose();
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
                        print(
                            (double.parse(_quantitycontroller.text.trim()) * 4)
                                    .round() /
                                4);

                        //     serviceLocator.get<AuthBloc>().add(
                        //           UpdatePasswordEvent(
                        //             serviceLocator
                        //                 .get<AuthBloc>()
                        //                 .state
                        //                 .user!
                        //                 .email,
                        //             _currentPasswordController.text.trim(),
                        //             _newPasswordController.text.trim(),
                        //           ),
                        //         );
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
