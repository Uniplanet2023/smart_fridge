import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_fridge/config/routes/names.dart';
import 'package:smart_fridge/core/domain_layer_entities/item.dart';
import 'package:smart_fridge/core/resources/cuisine_list.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/core/util/hero_dialog_route.dart';
import 'package:smart_fridge/features/fridge_management/presentation/bloc/fridge_management_bloc.dart';
import 'package:smart_fridge/features/fridge_management/presentation/pages/edit_fridge_items_page.dart';
import 'package:smart_fridge/features/fridge_management/presentation/widgets/fridge_item.dart';
import 'package:smart_fridge/features/recipe_generation/presentation/bloc/bloc/recipe_generation_bloc.dart';
import 'package:smart_fridge/features/recipe_generation/presentation/pages/generated_recipes_page.dart';

class FridgeItemsPage extends StatefulWidget {
  const FridgeItemsPage({super.key});

  @override
  State<FridgeItemsPage> createState() => _FridgeItemsPageState();
}

class _FridgeItemsPageState extends State<FridgeItemsPage> {
  // A list of bool equal to the size of fridge items that is used to track which
  // items are checked
  List<bool> checkedItems = [];
  final List<Item> selectedItems = [];
  String? selectedCuisine;

  @override
  void initState() {
    super.initState();
    context.read<FridgeManagementBloc>().add(LoadFridgeItemsEvent());
  }

  void handleCheckboxChange(int index, bool? isChecked, Item item) {
    setState(() {
      checkedItems[index] = isChecked ?? false;
      if (isChecked ?? false) {
        selectedItems.add(item);
      } else {
        selectedItems.remove(item);
      }
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
    return MultiBlocListener(
      listeners: [
        BlocListener<RecipeGenerationBloc, RecipeGenerationState>(
          listener: (context, state) {
            if (state is RecipeGenerated) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GeneratedRecipesPage(
                    generatedRecipes: state.recipes,
                  ),
                ),
              );
            } else if (state is RecipeGenerationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  content: Text(
                    state.message,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface),
                  ),
                ),
              );
            }
          },
        ),
        BlocListener<FridgeManagementBloc, FridgeManagementState>(
            listener: (context, state) {
          if (state is FridgeManagementItemDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                content: Text(
                  "Item Deleted!",
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
                  state.message,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inverseSurface),
                ),
              ),
            );
          }
        }),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
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
                        BlocBuilder<FridgeManagementBloc,
                            FridgeManagementState>(
                          builder: (context, state) {
                            if (state is FridgeManagementLoaded) {
                              // populate list with false bool value
                              // false -> item at index is unchecked, true -> item at index is checked
                              if (checkedItems.length != state.items.length) {
                                checkedItems = List<bool>.generate(
                                    state.items.length, (index) => false);
                              }
                              // sort items based on expiry date
                              state.items.sort((a, b) =>
                                  a.expiryDate.compareTo(b.expiryDate));
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: state.items.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
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
                                              quantity:
                                                  state.items[index].quantity,
                                              expiryDate:
                                                  state.items[index].expiryDate,
                                              isChecked: checkedItems[index],
                                              onChangeItemDetails: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditFridgeItemsPage(
                                                            item: state
                                                                .items[index]),
                                                  ),
                                                );
                                              },
                                              onDeleteItem: () {
                                                removeItem(
                                                    index, state.items[index]);
                                              },
                                              checkboxOnChange: (bool? value) {
                                                handleCheckboxChange(index,
                                                    value, state.items[index]);
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (isAnyItemSelected) // Show button only if selected
                              Hero(
                                tag: _heroGenerateRecipe,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        HeroDialogRoute(builder: (context) {
                                      return _GenerateRecipePopupCard(
                                        selectedItems: selectedItems,
                                      );
                                    }));
                                  },
                                  style: ButtonStyle(
                                    side: WidgetStateProperty.all(
                                      BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryFixedDim,
                                          width: 2),
                                    ),
                                  ),
                                  label: Text(
                                    'Generate Recipe',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  icon: Icon(
                                    Icons.auto_awesome_outlined,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                                  ),
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
            BlocBuilder<RecipeGenerationBloc, RecipeGenerationState>(
              builder: (context, state) {
                if (state is RecipeGenerating) {
                  return Container(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceDim
                        .withOpacity(0.5),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(height: 10.h),
                          Text(
                            'Generating ...',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant, // Change this to your desired color
                                    fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Tag-value used for the generate recipe button.
const String _heroGenerateRecipe = 'add-todo-hero';

// _GenerateRecipePopupCard.dart
class _GenerateRecipePopupCard extends StatelessWidget {
  final List<Item> selectedItems;

  const _GenerateRecipePopupCard({
    required this.selectedItems,
  });

  @override
  Widget build(BuildContext context) {
    String? selectedCuisine;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroGenerateRecipe,
          child: Material(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Cuisine',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    DropdownSearch<String>(
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: true,
                      ),
                      items: cuisines_200,
                      onChanged: (value) {
                        if (value != null) {
                          selectedCuisine = value;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (selectedCuisine == null) {
                              return;
                            }
                            // Close the popup after selecting the cuisine
                            serviceLocator<RecipeGenerationBloc>().add(
                              GenerateRecipeEvent(
                                ingredients: selectedItems,
                                cuisine: selectedCuisine!,
                              ),
                            );
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Generate',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
