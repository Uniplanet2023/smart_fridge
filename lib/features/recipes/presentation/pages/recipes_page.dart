import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_fridge/config/widgets/custom_textfield.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/features/recipes/presentation/bloc/recipe_bloc.dart';

import '../widgets/recipe_card.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  final TextEditingController searchController = TextEditingController();
  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();

    // Initially fetch all recipes
    serviceLocator<RecipeBloc>().add(FetchRecipesEvent());

    // Add listener to search controller
    searchController.addListener(_onSearchChanged);
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (!_isSearchVisible) {
        // If search bar is hidden, clear the search text and fetch all recipes
        searchController.clear();
        serviceLocator<RecipeBloc>().add(FetchRecipesEvent());
      }
    });
  }

  void _onSearchChanged() {
    final query = searchController.text;
    if (query.isEmpty) {
      // If search field is empty, fetch all recipes
      serviceLocator<RecipeBloc>().add(FetchRecipesEvent());
    } else {
      // If there is a search query, start searching
      serviceLocator<RecipeBloc>().add(SearchRecipeStartedEvent(query));
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Recpies',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: _toggleSearch,
                      child: const Icon(
                        Icons.search_sharp,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              _isSearchVisible
                  ? CustomTextField(
                      prefixIcon: const Icon(Icons.search_sharp),
                      controller: searchController,
                      hintText: 'Search saved recipes',
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<RecipeBloc, RecipeState>(
                builder: (context, state) {
                  if (state is RecipeLoaded) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.recipes.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              RecipeCard(
                                recipe: state.recipes[index],
                              ),
                              SizedBox(
                                height: 5.h,
                              )
                            ],
                          );
                        },
                      ),
                    );
                  } else if (state is RecipeSearchSuccess) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.recipes.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              RecipeCard(
                                recipe: state.recipes[index],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (state is RecipeSearchResultEmpty) {
                    return const Center(
                      child: Text('No matching recipes found!'),
                    );
                  } else if (state is RecipeEmpty) {
                    return const Center(
                      child: Text('No saved recipes!'),
                    );
                  } else {
                    return const Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator.adaptive(),
                          Text('loading ...')
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
