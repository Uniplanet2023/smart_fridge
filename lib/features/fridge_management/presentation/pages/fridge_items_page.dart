import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_fridge/config/routes/names.dart';
import 'package:smart_fridge/core/entities/item.dart';
import 'package:smart_fridge/features/fridge_management/presentation/bloc/fridge_management_bloc.dart';
import 'package:smart_fridge/features/fridge_management/presentation/pages/edit_fridge_items_page.dart';
import 'package:smart_fridge/features/fridge_management/presentation/widgets/fridge_item.dart';

class FridgeItemsPage extends StatefulWidget {
  const FridgeItemsPage({super.key});

  @override
  State<FridgeItemsPage> createState() => _FridgeItemsPageState();
}

class _FridgeItemsPageState extends State<FridgeItemsPage> {
  // A list of bool equal to the size of fridge items that is used to track which
  // items are checked
  List<bool> checkedItems = [];

  @override
  void initState() {
    super.initState();
    context.read<FridgeManagementBloc>().add(LoadFridgeItemsEvent());
  }

  void handleCheckboxChange(int index, bool? isChecked) {
    setState(() {
      checkedItems[index] = isChecked ?? false;
    });
  }

  void removeItem(int index, Item item) {
    setState(() {
      checkedItems.removeAt(index);
    });
    context.read<FridgeManagementBloc>().add(DeleteFridgeItemEvent(item));
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
                  BlocBuilder<FridgeManagementBloc, FridgeManagementState>(
                    builder: (context, state) {
                      if (state is FridgeManagementLoaded) {
                        // populate list with false bool value
                        // false -> item at index is unchecked, true -> item at index is checked
                        if (checkedItems.length != state.items.length) {
                          checkedItems = List<bool>.generate(
                              state.items.length, (index) => false);
                        }
                        // sort items based on expiry date
                        state.items.sort(
                            (a, b) => a.expiryDate.compareTo(b.expiryDate));
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.items.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
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
                                        itemName: state.items[index].name,
                                        quantity: state.items[index].quantity,
                                        expiryDate:
                                            state.items[index].expiryDate,
                                        isChecked: checkedItems[index],
                                        onChangeItemDetails: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditFridgeItemsPage(
                                                      item: state.items[index]),
                                            ),
                                          );
                                        },
                                        onDeleteItem: () {
                                          removeItem(index, state.items[index]);
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
                        );
                      } else if (state is FridgeManagementLoading) {
                        const Expanded(
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        );
                      }
                      return const Expanded(
                        child: Center(
                          child: Text('No Items Added'),
                        ),
                      );
                    },
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
