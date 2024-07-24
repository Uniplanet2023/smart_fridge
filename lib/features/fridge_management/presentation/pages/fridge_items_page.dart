import 'package:flutter/material.dart';
import 'package:smart_fridge/config/routes/names.dart';
import 'package:smart_fridge/core/entities/item.dart';
import 'package:smart_fridge/features/fridge_management/presentation/pages/edit_fridge_items_page.dart';
import 'package:smart_fridge/features/fridge_management/presentation/widgets/fridge_item.dart';

class FridgeItemsPage extends StatefulWidget {
  const FridgeItemsPage({super.key});

  @override
  State<FridgeItemsPage> createState() => _FridgeItemsPageState();
}

class _FridgeItemsPageState extends State<FridgeItemsPage> {
  List<Item> fridgeItems = [
    Item(
        name: 'Milk long title long title long title fasaksjdlka',
        quantity: 1.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 1))),
    Item(
        name: 'Milk',
        quantity: 2.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 14))),
    Item(
        name: 'Tuna',
        quantity: 12.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 4))),
    Item(
        name: 'Tomatoes',
        quantity: 10.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 3))),
    Item(
        name: 'Eggs',
        quantity: 6.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 7))),
    Item(
        name: 'Butter',
        quantity: 1.5,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 30))),
    Item(
        name: 'Cheese',
        quantity: 0.5,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 15))),
    Item(
        name: 'Yogurt',
        quantity: 3.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 10))),
    Item(
        name: 'Apples',
        quantity: 8.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 5))),
    Item(
        name: 'Bananas',
        quantity: 5.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 2))),
    Item(
        name: 'Chicken Breast',
        quantity: 4.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 6))),
    Item(
        name: 'Broccoli',
        quantity: 3.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 4))),
    Item(
        name: 'Carrots',
        quantity: 9.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 9))),
    Item(
        name: 'Orange Juice',
        quantity: 2.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 12))),
    Item(
        name: 'Salmon',
        quantity: 1.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 3))),
    Item(
        name: 'Ham',
        quantity: 1.2,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 20))),
    Item(
        name: 'Grapes',
        quantity: 2.5,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 5))),
    Item(
        name: 'Cucumber',
        quantity: 7.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 7))),
    Item(
        name: 'Spinach',
        quantity: 1.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 2))),
    Item(
        name: 'Almond Milk',
        quantity: 2.0,
        unitPrice: 0,
        totalPrice: 0,
        expiryDate: DateTime.now().add(const Duration(days: 30))),
  ];
  // A list of bool equal to the size of fridge items that is used to track which
  // items are checked
  List<bool> checkedItems = [];

  @override
  void initState() {
    super.initState();
    // sort items based on expiry date
    fridgeItems.sort((a, b) => a.expiryDate.compareTo(b.expiryDate));
    // populate list with false bool value
    // false -> item at index is unchecked, true -> item at index is checked
    checkedItems = List<bool>.generate(fridgeItems.length, (index) => false);
  }

  void handleCheckboxChange(int index, bool? isChecked) {
    setState(() {
      checkedItems[index] = isChecked ?? false;
    });
  }

  void removeItem(int index) {
    setState(() {
      fridgeItems.removeAt(index);
      checkedItems.removeAt(index);
    });
  }

  bool get isAnyItemSelected {
    return checkedItems.any((isChecked) => isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Fridge Items',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.addFridgeItemsPage);
                          },
                          child: const Icon(
                            Icons.add,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: fridgeItems.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(18),
                                ),
                                border: Border(
                                  bottom: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inverseSurface),
                                ),
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainer),
                            child: Column(
                              children: [
                                FridgeItem(
                                  itemName: fridgeItems[index].name,
                                  quantity: fridgeItems[index].quantity,
                                  expiryDate: fridgeItems[index].expiryDate,
                                  isChecked: checkedItems[index],
                                  onChangeItemDetails: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditFridgeItemsPage(
                                                item: fridgeItems[index]),
                                      ),
                                    );
                                  },
                                  onDeleteItem: () {
                                    removeItem(index);
                                  },
                                  checkboxOnChange: (bool? value) {
                                    handleCheckboxChange(index, value);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (isAnyItemSelected) // Show button only if selected
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ButtonStyle(
                            side: WidgetStatePropertyAll(
                              BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryFixedDim,
                                  width: 2),
                            ),
                          ),
                          label: Text(
                            'Generate Recipe',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          icon: Icon(
                            Icons.auto_awesome_outlined,
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
