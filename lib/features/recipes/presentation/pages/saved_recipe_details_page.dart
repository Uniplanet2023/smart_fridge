import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_fridge/config/routes/names.dart';
import 'package:smart_fridge/config/widgets/custom_button.dart';
import 'package:smart_fridge/core/domain_layer_entities/save_recipe.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/features/recipes/presentation/bloc/recipe_bloc.dart';

class SavedRecipeDetailsPage extends StatefulWidget {
  final SaveRecipe recipe;

  const SavedRecipeDetailsPage({required this.recipe, super.key});

  @override
  State<SavedRecipeDetailsPage> createState() => _SavedRecipeDetailsPageState();
}

class _SavedRecipeDetailsPageState extends State<SavedRecipeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RecipeBloc, RecipeState>(
      listener: (context, state) {
        if (state is RecipeDeletionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              content: Text(
                'Recipe Deleted!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ),
          );
        } else if (state is RecipeError) {
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recipe Detail',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    serviceLocator<RecipeBloc>()
                        .add(DeleteRecipeEvent(widget.recipe));
                  },
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: Theme.of(context).colorScheme.error,
                  ))
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cuisine:',
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                Text(
                  '- ${widget.recipe.cuisine}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 18.h),
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
                _buildIngredients(),
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
                _buildInstructions(),
                SizedBox(height: 4.h),
                const Divider(
                  thickness: 2,
                ),
                SizedBox(height: 4.h),
                CustomButton(
                  text: 'Post your Cooking',
                  width: 1.sw,
                  fontSize: 13.sp,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.postRecipeImagePage,
                        arguments: widget.recipe);
                  },
                  icon: const Icon(Icons.add_box_outlined),
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildIngredients() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.recipe.ingredients.length,
      itemBuilder: (context, itemIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            '- ${widget.recipe.ingredients[itemIndex]}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }

  _buildInstructions() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.recipe.instructions.length,
      itemBuilder: (context, instructionIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            widget.recipe.instructions[instructionIndex],
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }
}
