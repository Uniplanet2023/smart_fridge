import 'package:flutter/material.dart';

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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const Divider(
                thickness: 1,
              ),
              const Text(
                'Ingredients:',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.recipeIngredients[0],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              widget.recipeIngredients.length < 2
                  ? const SizedBox()
                  : Text(
                      widget.recipeIngredients[1],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400),
                    ),
              widget.recipeIngredients.length < 2
                  ? const SizedBox()
                  : Text(
                      widget.recipeIngredients[2],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400),
                    ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'read more >',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
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
