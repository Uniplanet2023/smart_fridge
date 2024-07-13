import 'package:flutter/material.dart';
import 'package:smart_fridge/features/items/presentation/widgets/fridge_item.dart';

class FridgeItemsPage extends StatefulWidget {
  const FridgeItemsPage({super.key});

  @override
  State<FridgeItemsPage> createState() => _FridgeItemsPageState();
}

class _FridgeItemsPageState extends State<FridgeItemsPage> {
  List<FridgeItemData> fridgeItems = [
    FridgeItemData(
        itemName: 'Milk long title long title long title fasaksjdlka',
        quantity: 1.0,
        expiryDate: DateTime.now().add(const Duration(days: 1))),
    FridgeItemData(
        itemName: 'Milk',
        quantity: 1.0,
        expiryDate: DateTime.now().add(const Duration(days: 1))),
    FridgeItemData(
        itemName: 'Eggs',
        quantity: 12.0,
        expiryDate: DateTime.now().add(const Duration(days: 7))),
    FridgeItemData(
        itemName: 'Butter',
        quantity: 2.0,
        expiryDate: DateTime.now().add(const Duration(days: 15))),
    FridgeItemData(
        itemName: 'Cheese',
        quantity: 1.5,
        expiryDate: DateTime.now().add(const Duration(days: 20))),
    FridgeItemData(
        itemName: 'Yogurt',
        quantity: 3.0,
        expiryDate: DateTime.now().add(const Duration(days: 5))),
    FridgeItemData(
        itemName: 'Lettuce',
        quantity: 1.0,
        expiryDate: DateTime.now().add(const Duration(days: 3))),
    FridgeItemData(
        itemName: 'Tomatoes',
        quantity: 6.0,
        expiryDate: DateTime.now().add(const Duration(days: 4))),
    FridgeItemData(
        itemName: 'Carrots',
        quantity: 10.0,
        expiryDate: DateTime.now().add(const Duration(days: 10))),
    FridgeItemData(
        itemName: 'Broccoli',
        quantity: 2.0,
        expiryDate: DateTime.now().add(const Duration(days: 6))),
    FridgeItemData(
        itemName: 'Spinach',
        quantity: 1.0,
        expiryDate: DateTime.now().add(const Duration(days: 2))),
    FridgeItemData(
        itemName: 'Cucumber',
        quantity: 3.0,
        expiryDate: DateTime.now().add(const Duration(days: 8))),
    FridgeItemData(
        itemName: 'Peppers',
        quantity: 5.0,
        expiryDate: DateTime.now().add(const Duration(days: 12))),
    FridgeItemData(
        itemName: 'Onions',
        quantity: 4.0,
        expiryDate: DateTime.now().add(const Duration(days: 9))),
    FridgeItemData(
        itemName: 'Garlic',
        quantity: 6.0,
        expiryDate: DateTime.now().add(const Duration(days: 18))),
    FridgeItemData(
        itemName: 'Chicken Breast',
        quantity: 2.0,
        expiryDate: DateTime.now().add(const Duration(days: 5))),
    FridgeItemData(
        itemName: 'Ground Beef',
        quantity: 1.0,
        expiryDate: DateTime.now().add(const Duration(days: 3))),
    FridgeItemData(
        itemName: 'Pork Chops',
        quantity: 4.0,
        expiryDate: DateTime.now().add(const Duration(days: 7))),
    FridgeItemData(
        itemName: 'Fish Fillets',
        quantity: 5.0,
        expiryDate: DateTime.now().add(const Duration(days: 2))),
    FridgeItemData(
        itemName: 'Shrimp',
        quantity: 1.0,
        expiryDate: DateTime.now().add(const Duration(days: 4))),
    FridgeItemData(
        itemName: 'Bacon',
        quantity: 2.0,
        expiryDate: DateTime.now().add(const Duration(days: 6))),
    FridgeItemData(
        itemName: 'Sausages',
        quantity: 8.0,
        expiryDate: DateTime.now().add(const Duration(days: 10))),
    FridgeItemData(
        itemName: 'Ham',
        quantity: 3.0,
        expiryDate: DateTime.now().add(const Duration(days: 12))),
    FridgeItemData(
        itemName: 'Turkey',
        quantity: 1.0,
        expiryDate: DateTime.now().add(const Duration(days: 5))),
    FridgeItemData(
        itemName: 'Tofu',
        quantity: 2.0,
        expiryDate: DateTime.now().add(const Duration(days: 7))),
    FridgeItemData(
        itemName: 'Mushrooms',
        quantity: 1.0,
        expiryDate: DateTime.now().add(const Duration(days: 3))),
    FridgeItemData(
        itemName: 'Bell Peppers',
        quantity: 6.0,
        expiryDate: DateTime.now().add(const Duration(days: 8))),
    FridgeItemData(
        itemName: 'Zucchini',
        quantity: 4.0,
        expiryDate: DateTime.now().add(const Duration(days: 6))),
    FridgeItemData(
        itemName: 'Eggplant',
        quantity: 1.0,
        expiryDate: DateTime.now().add(const Duration(days: 5))),
    FridgeItemData(
        itemName: 'Celery',
        quantity: 2.0,
        expiryDate: DateTime.now().add(const Duration(days: 7))),
    FridgeItemData(
        itemName: 'Green Beans',
        quantity: 3.0,
        expiryDate: DateTime.now().add(const Duration(days: 9))),
  ];

  @override
  void initState() {
    super.initState();
    fridgeItems.sort((a, b) => a.expiryDate.compareTo(b.expiryDate));
  }

  void handleCheckboxChange(int index, bool? isChecked) {
    setState(() {
      fridgeItems[index].isChecked = isChecked ?? false;
    });
  }

  bool get isAnyItemSelected {
    return fridgeItems.any((item) => item.isChecked);
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
                          onTap: () {},
                          child: const Icon(
                            Icons.add,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: fridgeItems.length,
                      itemBuilder: (context, index) {
                        return FridgeItem(
                          itemName: fridgeItems[index].itemName,
                          quantity: fridgeItems[index].quantity,
                          expiryDate: fridgeItems[index].expiryDate,
                          isChecked: fridgeItems[index].isChecked,
                          onChangeItemDetails: () {},
                          onDeleteItem: () {},
                          checkboxOnChange: (bool? value) {
                            handleCheckboxChange(index, value);
                          },
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
                          label: Text(
                            'Generate Recipe',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          icon: const Icon(
                            Icons.auto_awesome_outlined,
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

class FridgeItemData {
  final String itemName;
  final double quantity;
  final DateTime expiryDate;
  bool isChecked;

  FridgeItemData({
    required this.itemName,
    required this.quantity,
    required this.expiryDate,
    this.isChecked = false,
  });
}
