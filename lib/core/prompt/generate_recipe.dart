import '../domain_layer_entities/item.dart';

String generateRecipePrompt(List<Item> ingredientsList, String cuisine) {
  // Convert each item in the ingredientsList to a string representation
  String formattedIngredients = ingredientsList
      .map((item) =>
          'name :${item.name} quantity : ${item.quantity} , totalPrice: ${item.totalPrice}, expiryDate:${item.expiryDate.toIso8601String()}')
      .join(', ');

  return '''
    Generate 5 recipes using the following ingredients and specify the cuisine type. 
    Each recipe should include a name, the cuisine type, a list of ingredients with their quantities, 
    detailed cooking instructions, and a flag indicating whether the recipe is shared. 
    The ingredients should be used as provided. If given ingredients are not food items ignore them.
    If all given ingredients are not food items, the response should be an empty list. 
    
    The response should be in JSON format as specified below.

    **Ingredients:**
    $formattedIngredients

    **Cuisine Type:** $cuisine 

    **JSON Format:**
    [
        {
            "name": "Recipe Name 1",
            "cuisine": "$cuisine",
            "ingredients": [
                {
                    "name": "ingredient1_name",
                    "quantity": ingredient1_quantity,
                    "unitPrice": ingredient1_unitPrice,
                    "totalPrice": ingredient1_totalPrice,
                    "expiryDate": "ingredient1_expiryDate"
                },
                ...
            ],
            "instructions": [
                "Step 1: ...",
                "Step 2: ..."
            ],
            "shared": false
        },
        ...
        {
            "name": "Recipe Name 5",
            "cuisine": "$cuisine",
            "ingredients": [
                {
                    "name": "ingredient1_name",
                    "quantity": ingredient1_quantity,
                    "unitPrice": ingredient1_unitPrice,
                    "totalPrice": ingredient1_totalPrice,
                    "expiryDate": "ingredient1_expiryDate"
                },
                ...
            ],
            "instructions": [
                "Step 1: ...",
                "Step 2: ..."
            ],
            "shared": false
        }
    ]
    ''';
}


/**
 * Task 
 * Context
 * exemplar
 * persona
 * format
 * tone
 * 
 * 
 * 
 * Generate 5 recipes using the following ingredients and specify the cuisine type. 
 * Each recipe should include a name, the cuisine type, a list of ingredients with their quantities, 
 * detailed cooking instructions, and a flag indicating whether the recipe is shared. 
 * The ingredients should be used as provided. The response should be in JSON format as specified below.

 */