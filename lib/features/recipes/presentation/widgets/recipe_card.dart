import 'package:flutter/material.dart';
import 'package:smart_fridge/config/routes/names.dart';
import 'package:smart_fridge/core/domain_layer_entities/save_recipe.dart';
import 'package:smart_fridge/features/recipes/presentation/pages/saved_recipe_details_page.dart';

class RecipeCard extends StatefulWidget {
  final SaveRecipe recipe;

  const RecipeCard({
    super.key,
    required this.recipe,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.saveRecipeDetailPage,
          arguments: widget.recipe,
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.recipe.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Divider(
                  thickness: 3,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                Text(
                  'Ingredients:',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                for (var i = 0;
                    i < widget.recipe.ingredients.length && i < 3;
                    i++)
                  Text(
                    widget.recipe.ingredients[i],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'read more >',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.inverseSurface),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
