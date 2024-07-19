import 'package:flutter/material.dart';
import 'package:smart_fridge/config/widgets/custom_textfield.dart';

import '../widgets/recipe_card.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  final TextEditingController searchController = TextEditingController();

  List<RecipeItemData> recipeItems = [
    RecipeItemData(
      recipeName: 'Banana Cabbage Smoothie',
      recipeIngredients: [
        '1 cup chopped red cabbage (or green cabbage)',
        '1 ripe banana, frozen or chilled',
        '1 cup milk (dairy or non-dairy)',
        '1 tablespoon raw honey or maple syrup (optional)',
        '¼ cup chopped pineapple (optional)',
        '½ cup ice cubes (optional)',
      ],
      recipeInstructions: [
        'Wash and chop the cabbage into small pieces that will fit easily in your blender.',
        'Peel and chop the banana. If you want a thicker and colder smoothie, freeze the banana chunks for a few hours beforehand.',
        'Add the chopped cabbage, banana, milk, honey or maple syrup (if using), pineapple (if using), and ice cubes (if using) to your blender.',
        'Blend until smooth and creamy. You may need to add more milk or ice cubes depending on your desired consistency.',
        'Taste and adjust sweetness with additional honey or maple syrup if desired.',
      ],
    ),
    RecipeItemData(
      recipeName: 'Avocado Toast',
      recipeIngredients: [
        '1 ripe avocado',
        '2 slices of whole grain bread',
        '1 tablespoon olive oil',
        'Salt and pepper to taste',
        'Red pepper flakes (optional)',
        '1 teaspoon lemon juice (optional)',
      ],
      recipeInstructions: [
        'Toast the bread slices until they are golden brown.',
        'Cut the avocado in half, remove the pit, and scoop the flesh into a bowl.',
        'Mash the avocado with a fork and mix in olive oil, salt, pepper, and lemon juice if using.',
        'Spread the mashed avocado mixture onto the toasted bread slices.',
        'Sprinkle with red pepper flakes if desired.',
      ],
    ),
    RecipeItemData(
      recipeName: 'Vegetable Stir-Fry',
      recipeIngredients: [
        '1 cup broccoli florets',
        '1 cup sliced carrots',
        '1 bell pepper, sliced',
        '1 cup snap peas',
        '2 tablespoons soy sauce',
        '1 tablespoon olive oil',
        '1 teaspoon minced garlic',
        '1 teaspoon grated ginger',
        'Cooked rice or noodles',
      ],
      recipeInstructions: [
        'Heat the olive oil in a large pan over medium-high heat.',
        'Add the minced garlic and grated ginger, and sauté for 1-2 minutes until fragrant.',
        'Add the broccoli, carrots, bell pepper, and snap peas to the pan.',
        'Stir-fry the vegetables for 5-7 minutes until they are tender but still crisp.',
        'Pour the soy sauce over the vegetables and stir to combine.',
        'Serve the stir-fry over cooked rice or noodles.',
      ],
    ),
    RecipeItemData(
      recipeName: 'Chicken Caesar Salad',
      recipeIngredients: [
        '2 cups romaine lettuce, chopped',
        '1 cup cooked chicken breast, sliced',
        '¼ cup grated Parmesan cheese',
        '½ cup croutons',
        '¼ cup Caesar dressing',
        '1 tablespoon lemon juice',
      ],
      recipeInstructions: [
        'In a large bowl, combine the chopped romaine lettuce, sliced chicken breast, grated Parmesan cheese, and croutons.',
        'Drizzle the Caesar dressing and lemon juice over the salad.',
        'Toss the salad until all ingredients are evenly coated with dressing.',
        'Serve immediately.',
      ],
    ),
    RecipeItemData(
      recipeName: 'Spaghetti Carbonara',
      recipeIngredients: [
        '200g spaghetti',
        '100g pancetta, diced',
        '2 large eggs',
        '½ cup grated Parmesan cheese',
        '2 cloves garlic, minced',
        'Salt and pepper to taste',
        'Fresh parsley, chopped (optional)',
      ],
      recipeInstructions: [
        'Cook the spaghetti according to package instructions until al dente. Reserve some pasta water and drain.',
        'In a large pan, cook the diced pancetta over medium heat until crispy.',
        'Add the minced garlic to the pan and cook for 1-2 minutes.',
        'In a bowl, whisk together the eggs and grated Parmesan cheese.',
        'Add the cooked spaghetti to the pan with pancetta and garlic.',
        'Remove the pan from heat and quickly stir in the egg and cheese mixture, adding reserved pasta water if needed to create a creamy sauce.',
        'Season with salt and pepper to taste and garnish with chopped parsley if desired.',
      ],
    ),
    RecipeItemData(
      recipeName: 'Chocolate Chip Cookies',
      recipeIngredients: [
        '1 cup unsalted butter, softened',
        '1 cup granulated sugar',
        '1 cup brown sugar',
        '2 large eggs',
        '1 teaspoon vanilla extract',
        '3 cups all-purpose flour',
        '1 teaspoon baking soda',
        '½ teaspoon baking powder',
        '1 teaspoon salt',
        '2 cups chocolate chips',
      ],
      recipeInstructions: [
        'Preheat the oven to 350°F (175°C).',
        'In a large bowl, cream together the softened butter, granulated sugar, and brown sugar until smooth.',
        'Beat in the eggs one at a time, then stir in the vanilla extract.',
        'Combine the flour, baking soda, baking powder, and salt; gradually blend into the butter mixture.',
        'Stir in the chocolate chips by hand using a wooden spoon.',
        'Drop dough by rounded spoonfuls onto ungreased cookie sheets.',
        'Bake for 8 to 10 minutes in the preheated oven, or until edges are nicely browned.',
        'Cool on baking sheets for a few minutes before transferring to wire racks to cool completely.',
      ],
    ),
    RecipeItemData(
      recipeName: 'Greek Yogurt Parfait',
      recipeIngredients: [
        '1 cup Greek yogurt',
        '½ cup granola',
        '1 cup mixed berries (blueberries, strawberries, raspberries)',
        '1 tablespoon honey',
        '1 teaspoon chia seeds (optional)',
      ],
      recipeInstructions: [
        'In a glass or bowl, layer half of the Greek yogurt.',
        'Add a layer of granola and mixed berries on top of the yogurt.',
        'Drizzle with honey and sprinkle with chia seeds if using.',
        'Repeat the layers with the remaining yogurt, granola, and berries.',
        'Finish with a final drizzle of honey.',
      ],
    ),
    RecipeItemData(
      recipeName: 'Mango Salsa',
      recipeIngredients: [
        '2 ripe mangoes, peeled and diced',
        '1 red bell pepper, diced',
        '1 small red onion, finely chopped',
        '1 jalapeño, seeded and minced',
        '¼ cup fresh cilantro, chopped',
        'Juice of 1 lime',
        'Salt to taste',
      ],
      recipeInstructions: [
        'In a large bowl, combine the diced mangoes, red bell pepper, red onion, jalapeño, and fresh cilantro.',
        'Drizzle with lime juice and season with salt to taste.',
        'Toss all ingredients together until well combined.',
        'Serve immediately or refrigerate for up to 2 hours to let the flavors meld together.',
      ],
    ),
    RecipeItemData(
      recipeName: 'Vegetable Soup',
      recipeIngredients: [
        '2 tablespoons olive oil',
        '1 onion, chopped',
        '2 cloves garlic, minced',
        '2 carrots, sliced',
        '2 celery stalks, sliced',
        '1 zucchini, chopped',
        '1 can diced tomatoes (14.5 ounces)',
        '4 cups vegetable broth',
        '1 teaspoon dried thyme',
        '1 teaspoon dried basil',
        'Salt and pepper to taste',
        '1 cup spinach leaves',
      ],
      recipeInstructions: [
        'Heat the olive oil in a large pot over medium heat.',
        'Add the chopped onion and minced garlic, and sauté until tender.',
        'Add the sliced carrots, celery, and chopped zucchini to the pot.',
        'Stir in the diced tomatoes, vegetable broth, dried thyme, and dried basil.',
        'Season with salt and pepper to taste.',
        'Bring the soup to a boil, then reduce the heat and let it simmer for 20-25 minutes until the vegetables are tender.',
        'Stir in the spinach leaves and cook for an additional 5 minutes.',
        'Serve hot.',
      ],
    ),
    RecipeItemData(
      recipeName: 'Grilled Cheese Sandwich',
      recipeIngredients: [
        '4 slices of bread',
        '4 slices of cheese (cheddar, Swiss, or your choice)',
        '2 tablespoons butter, softened',
      ],
      recipeInstructions: [
        'Preheat a skillet over medium heat.',
        'Butter one side of each slice of bread.',
        'Place two slices of bread, buttered side down, on the skillet.',
        'Add a slice of cheese on top of each piece of bread.',
        'Top with the remaining slices of bread, buttered side up.',
        'Grill until the bread is golden brown and the cheese is melted, about 2-3 minutes per side.',
        'Serve immediately.',
      ],
    ),
  ];

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
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Recpies',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                  prefixIcon: const Icon(Icons.search_sharp),
                  controller: searchController,
                  hintText: 'Search saved recipes'),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: recipeItems.length,
                  itemBuilder: (context, index) {
                    return RecipeCard(
                        recipeName: recipeItems[index].recipeName,
                        recipeIngredients: recipeItems[index].recipeIngredients,
                        recipeInstructions:
                            recipeItems[index].recipeInstructions);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeItemData {
  final String recipeName;
  final List<String> recipeIngredients;
  final List<String> recipeInstructions;

  RecipeItemData({
    required this.recipeName,
    required this.recipeIngredients,
    required this.recipeInstructions,
  });
}
