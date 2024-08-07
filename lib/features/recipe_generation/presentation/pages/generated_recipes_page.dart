import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/features/recipe_generation/presentation/bloc/bloc/recipe_generation_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GeneratedRecipesPage extends StatefulWidget {
  final List<Recipe> generatedRecipes;
  const GeneratedRecipesPage({required this.generatedRecipes, super.key});

  @override
  State<GeneratedRecipesPage> createState() => _GeneratedRecipesPageState();
}

class _GeneratedRecipesPageState extends State<GeneratedRecipesPage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecipeGenerationBloc, RecipeGenerationState>(
      listener: (context, state) {
        if (state is RecipeSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              content: Text(
                'Recipe saved!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface),
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
        appBar: AppBar(
          title: Text(
            'Generated recipes',
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SmoothPageIndicator(
                controller: _pageController,
                count: widget.generatedRecipes.length,
                effect: WormEffect(
                  dotHeight: 8.0,
                  dotWidth: 8.0,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.generatedRecipes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    widget.generatedRecipes[index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    serviceLocator<RecipeGenerationBloc>().add(
                                        SaveRecipeEvent(
                                            widget.generatedRecipes[index]));
                                  },
                                  child: const Icon(
                                      Icons.bookmark_border_outlined),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            const Divider(
                              thickness: 2,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Ingredients:',
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4.h),
                            _buildIngredients(index),
                            SizedBox(height: 4.h),
                            const Divider(
                              thickness: 2,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Instructions:',
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4.h),
                            _buildInstructions(index),
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
      ),
    );
  }

  _buildIngredients(int index) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.generatedRecipes[index].ingredients.length,
      itemBuilder: (context, itemIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            '- ${widget.generatedRecipes[index].ingredients[itemIndex].name}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }

  _buildInstructions(int index) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.generatedRecipes[index].instructions.length,
      itemBuilder: (context, instructionIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            widget.generatedRecipes[index].instructions[instructionIndex],
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }
}
