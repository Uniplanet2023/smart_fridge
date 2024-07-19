import 'package:flutter/material.dart';
import 'package:smart_fridge/config/routes/names.dart';

class RecipeCard extends StatefulWidget {
  final String recipeName;
  final List<String> recipeIngredients;
  final List<String> recipeInstructions;
  const RecipeCard(
      {super.key,
      required this.recipeName,
      required this.recipeIngredients,
      required this.recipeInstructions});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.savedRecipeDetailsPage);
      },
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.recipeName,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Divider(
                thickness: 1,
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
              Text(
                widget.recipeIngredients[0],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
              widget.recipeIngredients.length < 2
                  ? const SizedBox()
                  : Text(
                      widget.recipeIngredients[1],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
              widget.recipeIngredients.length < 2
                  ? const SizedBox()
                  : Text(
                      widget.recipeIngredients[2],
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
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
