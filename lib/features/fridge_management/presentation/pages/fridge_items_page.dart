import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_fridge/config/routes/names.dart';
import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/core/isar_models/item.dart';
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

  // Sample Recipes
  List<Recipe> recipesMock = [
    Recipe(
      name: "Ultimate Gourmet Burger",
      cuisine: "American",
      ingredients: [
        Item(
          name:
              "500 grams of freshly ground premium beef with a high fat content",
          quantity: 1.0,
          unitPrice: 10.0,
          totalPrice: 10.0,
          expiryDate: DateTime.now().add(Duration(days: 2)),
        ),
        Item(
          name:
              "1 tablespoon of finely chopped fresh rosemary, thyme, and sage mix",
          quantity: 1.0,
          unitPrice: 1.0,
          totalPrice: 1.0,
          expiryDate: DateTime.now().add(Duration(days: 5)),
        ),
        Item(
          name: "2 cloves of garlic, minced to a fine paste",
          quantity: 1.0,
          unitPrice: 0.5,
          totalPrice: 0.5,
          expiryDate: DateTime.now().add(Duration(days: 7)),
        ),
        Item(
          name: "1 tablespoon of Worcestershire sauce for an umami kick",
          quantity: 1.0,
          unitPrice: 0.75,
          totalPrice: 0.75,
          expiryDate: DateTime.now().add(Duration(days: 365)),
        ),
        Item(
          name: "1 tablespoon of Dijon mustard for a subtle tang",
          quantity: 1.0,
          unitPrice: 0.75,
          totalPrice: 0.75,
          expiryDate: DateTime.now().add(Duration(days: 365)),
        ),
        Item(
          name: "Salt and pepper to taste",
          quantity: 1.0,
          unitPrice: 0.1,
          totalPrice: 0.1,
          expiryDate: DateTime.now().add(Duration(days: 365)),
        ),
        Item(
          name: "6 slices of cheddar cheese for that melty goodness",
          quantity: 1.0,
          unitPrice: 2.0,
          totalPrice: 2.0,
          expiryDate: DateTime.now().add(Duration(days: 15)),
        ),
        Item(
          name: "6 burger buns, lightly toasted to perfection",
          quantity: 1.0,
          unitPrice: 3.0,
          totalPrice: 3.0,
          expiryDate: DateTime.now().add(Duration(days: 3)),
        ),
        Item(
          name: "1 large red onion, thinly sliced into rings",
          quantity: 1.0,
          unitPrice: 1.0,
          totalPrice: 1.0,
          expiryDate: DateTime.now().add(Duration(days: 10)),
        ),
        Item(
          name: "2 large tomatoes, sliced thick",
          quantity: 1.0,
          unitPrice: 1.5,
          totalPrice: 1.5,
          expiryDate: DateTime.now().add(Duration(days: 7)),
        ),
        Item(
          name: "6 leaves of fresh lettuce, washed and dried",
          quantity: 1.0,
          unitPrice: 1.5,
          totalPrice: 1.5,
          expiryDate: DateTime.now().add(Duration(days: 5)),
        ),
        Item(
          name:
              "Special burger sauce (a mix of mayonnaise, ketchup, and relish)",
          quantity: 1.0,
          unitPrice: 2.0,
          totalPrice: 2.0,
          expiryDate: DateTime.now().add(Duration(days: 15)),
        ),
      ],
      instructions: [
        "1. Begin by finely chopping the fresh rosemary, thyme, and sage. These herbs will be used to enhance the flavor of the ground beef patties.",
        "2. In a large mixing bowl, combine the ground beef with the chopped herbs, minced garlic, Worcestershire sauce, Dijon mustard, salt, and pepper. Mix thoroughly until all the ingredients are well incorporated.",
        "3. Form the beef mixture into patties, each about 1/2 inch thick. Place them on a plate, cover with plastic wrap, and refrigerate for at least 30 minutes to allow the flavors to meld together.",
        "4. Preheat your grill to medium-high heat. Once heated, brush the grill grates with oil to prevent sticking. Place the burger patties on the grill and cook for 4-5 minutes per side for medium doneness. Adjust the cooking time to achieve your desired level of doneness.",
        "5. While the burgers are grilling, prepare the toppings. Slice the red onions into thin rings and the tomatoes into thick slices. Wash and dry the lettuce leaves.",
        "6. Toast the burger buns on the grill for about 1 minute, until they are lightly golden and crisp.",
        "7. Assemble the burgers by placing a patty on the bottom half of each bun. Add a slice of cheddar cheese on top of the patty, followed by lettuce, tomato slices, and red onion rings.",
        "8. Spread a generous amount of the special burger sauce on the top half of the bun and place it on top of the assembled burger. Serve immediately with a side of fries or salad.",
      ],
      shared: true,
    ),
    Recipe(
      name: 'Spaghetti Carbonara',
      cuisine: 'Italian',
      instructions: [
        'Boil water and cook spaghetti until al dente.',
        'Fry pancetta until crispy.',
        'Mix eggs and cheese in a bowl.',
        'Combine spaghetti, pancetta, and egg mixture.',
        'Serve immediately with extra cheese on top.'
      ],
      ingredients: [
        Item(
          name: 'Spaghetti',
          quantity: 200.0,
          unitPrice: 0.05,
          totalPrice: 10.0,
          expiryDate: DateTime(2024, 12, 31),
        ),
        Item(
          name: 'Pancetta',
          quantity: 100.0,
          unitPrice: 0.2,
          totalPrice: 20.0,
          expiryDate: DateTime(2024, 11, 15),
        ),
        Item(
          name: 'Eggs',
          quantity: 3.0,
          unitPrice: 0.5,
          totalPrice: 1.5,
          expiryDate: DateTime(2024, 08, 10),
        ),
        Item(
          name: 'Parmesan Cheese',
          quantity: 50.0,
          unitPrice: 0.4,
          totalPrice: 20.0,
          expiryDate: DateTime(2024, 09, 01),
        )
      ],
      shared: true,
    ),
    Recipe(
      name: 'Chicken Curry',
      cuisine: 'Indian',
      instructions: [
        'Marinate chicken with spices and yogurt.',
        'Heat oil and sauté onions, garlic, and ginger.',
        'Add tomatoes and cook until soft.',
        'Add chicken and cook until done.',
        'Serve hot with rice or naan.'
      ],
      ingredients: [
        Item(
          name: 'Chicken Breast',
          quantity: 500.0,
          unitPrice: 0.15,
          totalPrice: 75.0,
          expiryDate: DateTime(2024, 08, 15),
        ),
        Item(
          name: 'Yogurt',
          quantity: 100.0,
          unitPrice: 0.1,
          totalPrice: 10.0,
          expiryDate: DateTime(2024, 08, 12),
        ),
        Item(
          name: 'Onion',
          quantity: 1.0,
          unitPrice: 0.3,
          totalPrice: 0.3,
          expiryDate: DateTime(2024, 08, 20),
        ),
        Item(
          name: 'Garlic',
          quantity: 5.0,
          unitPrice: 0.05,
          totalPrice: 0.25,
          expiryDate: DateTime(2024, 08, 25),
        ),
        Item(
          name: 'Ginger',
          quantity: 20.0,
          unitPrice: 0.05,
          totalPrice: 1.0,
          expiryDate: DateTime(2024, 08, 25),
        ),
        Item(
          name: 'Tomatoes',
          quantity: 2.0,
          unitPrice: 0.5,
          totalPrice: 1.0,
          expiryDate: DateTime(2024, 08, 15),
        ),
        Item(
          name: 'Spices',
          quantity: 10.0,
          unitPrice: 0.2,
          totalPrice: 2.0,
          expiryDate: DateTime(2025, 01, 01),
        )
      ],
      shared: false,
    ),
    Recipe(
      name: 'Beef Tacos',
      cuisine: 'Mexican',
      instructions: [
        'Cook beef in a skillet until browned.',
        'Add taco seasoning and water.',
        'Simmer until thickened.',
        'Serve in taco shells with lettuce, cheese, and salsa.'
      ],
      ingredients: [
        Item(
          name: 'Ground Beef',
          quantity: 300.0,
          unitPrice: 0.2,
          totalPrice: 60.0,
          expiryDate: DateTime(2024, 08, 14),
        ),
        Item(
          name: 'Taco Seasoning',
          quantity: 1.0,
          unitPrice: 1.0,
          totalPrice: 1.0,
          expiryDate: DateTime(2025, 02, 01),
        ),
        Item(
          name: 'Taco Shells',
          quantity: 12.0,
          unitPrice: 0.1,
          totalPrice: 1.2,
          expiryDate: DateTime(2024, 09, 01),
        ),
        Item(
          name: 'Lettuce',
          quantity: 1.0,
          unitPrice: 0.5,
          totalPrice: 0.5,
          expiryDate: DateTime(2024, 08, 12),
        ),
        Item(
          name: 'Cheddar Cheese',
          quantity: 100.0,
          unitPrice: 0.3,
          totalPrice: 30.0,
          expiryDate: DateTime(2024, 09, 05),
        ),
        Item(
          name: 'Salsa',
          quantity: 50.0,
          unitPrice: 0.2,
          totalPrice: 10.0,
          expiryDate: DateTime(2024, 09, 15),
        )
      ],
      shared: true,
    ),
    Recipe(
      name: 'Sushi Rolls',
      cuisine: 'Japanese',
      instructions: [
        'Cook sushi rice and season with rice vinegar.',
        'Place seaweed on a bamboo mat.',
        'Spread rice on seaweed and add fillings.',
        'Roll tightly and slice into pieces.',
        'Serve with soy sauce, wasabi, and pickled ginger.'
      ],
      ingredients: [
        Item(
          name: 'Sushi Rice',
          quantity: 200.0,
          unitPrice: 0.3,
          totalPrice: 60.0,
          expiryDate: DateTime(2024, 09, 20),
        ),
        Item(
          name: 'Rice Vinegar',
          quantity: 50.0,
          unitPrice: 0.1,
          totalPrice: 5.0,
          expiryDate: DateTime(2025, 02, 28),
        ),
        Item(
          name: 'Nori (Seaweed)',
          quantity: 5.0,
          unitPrice: 0.5,
          totalPrice: 2.5,
          expiryDate: DateTime(2025, 01, 15),
        ),
        Item(
          name: 'Fresh Fish (Salmon/Tuna)',
          quantity: 100.0,
          unitPrice: 1.0,
          totalPrice: 100.0,
          expiryDate: DateTime(2024, 08, 08),
        ),
        Item(
          name: 'Cucumber',
          quantity: 1.0,
          unitPrice: 0.3,
          totalPrice: 0.3,
          expiryDate: DateTime(2024, 08, 05),
        ),
        Item(
          name: 'Avocado',
          quantity: 1.0,
          unitPrice: 0.8,
          totalPrice: 0.8,
          expiryDate: DateTime(2024, 08, 06),
        )
      ],
      shared: false,
    ),
    Recipe(
      name: 'Pad Thai',
      cuisine: 'Thai',
      instructions: [
        'Soak rice noodles in warm water.',
        'Stir-fry tofu, shrimp, and garlic in a hot pan.',
        'Add beaten eggs and scramble.',
        'Add noodles, tamarind paste, fish sauce, and sugar.',
        'Stir well and garnish with peanuts and lime wedges.'
      ],
      ingredients: [
        Item(
          name: 'Rice Noodles',
          quantity: 200.0,
          unitPrice: 0.2,
          totalPrice: 40.0,
          expiryDate: DateTime(2025, 01, 01),
        ),
        Item(
          name: 'Tofu',
          quantity: 100.0,
          unitPrice: 0.3,
          totalPrice: 30.0,
          expiryDate: DateTime(2024, 08, 12),
        ),
        Item(
          name: 'Shrimp',
          quantity: 150.0,
          unitPrice: 0.5,
          totalPrice: 75.0,
          expiryDate: DateTime(2024, 08, 08),
        ),
        Item(
          name: 'Garlic',
          quantity: 10.0,
          unitPrice: 0.05,
          totalPrice: 0.5,
          expiryDate: DateTime(2024, 08, 25),
        ),
        Item(
          name: 'Eggs',
          quantity: 2.0,
          unitPrice: 0.5,
          totalPrice: 1.0,
          expiryDate: DateTime(2024, 08, 10),
        ),
        Item(
          name: 'Tamarind Paste',
          quantity: 50.0,
          unitPrice: 0.2,
          totalPrice: 10.0,
          expiryDate: DateTime(2025, 03, 01),
        ),
        Item(
          name: 'Fish Sauce',
          quantity: 20.0,
          unitPrice: 0.1,
          totalPrice: 2.0,
          expiryDate: DateTime(2025, 04, 15),
        ),
        Item(
          name: 'Sugar',
          quantity: 10.0,
          unitPrice: 0.05,
          totalPrice: 0.5,
          expiryDate: DateTime(2025, 05, 01),
        ),
        Item(
          name: 'Peanuts',
          quantity: 30.0,
          unitPrice: 0.2,
          totalPrice: 6.0,
          expiryDate: DateTime(2025, 01, 01),
        ),
        Item(
          name: 'Lime',
          quantity: 1.0,
          unitPrice: 0.3,
          totalPrice: 0.3,
          expiryDate: DateTime(2024, 08, 10),
        )
      ],
      shared: true,
    )
  ];

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
    return BlocListener<RecipeGenerationBloc, RecipeGenerationState>(
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
