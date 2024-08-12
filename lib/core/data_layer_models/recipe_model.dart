import 'package:smart_fridge/core/data_layer_models/item_model.dart';
import 'package:smart_fridge/core/domain_layer_entities/recipe.dart';

// Model used for Recipe generation - data layer
class RecipeModel {
  late String name;
  late String cuisine;
  late List<String> instructions;
  late List<ItemModel> ingredients;
  late bool shared;

  RecipeModel({
    required this.name,
    required this.cuisine,
    required this.instructions,
    required this.ingredients,
    required this.shared,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      name: json['name'] as String? ?? '',
      cuisine: json['cuisine'] as String? ?? '',
      ingredients: (json['ingredients'] as List)
          .map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      shared: json['shared'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cuisine': cuisine,
      'ingredients': ingredients,
      'instructions': instructions,
      'shared': shared
    };
  }

  factory RecipeModel.fromDomain(Recipe recipe) {
    return RecipeModel(
      name: recipe.name,
      cuisine: recipe.cuisine,
      ingredients:
          recipe.ingredients.map((item) => ItemModel.fromDomain(item)).toList(),
      instructions: recipe.instructions,
      shared: recipe.shared,
    );
  }

  Recipe toDomain() {
    return Recipe(
      name: name,
      cuisine: cuisine,
      ingredients:
          ingredients.map((itemModel) => itemModel.toDomain()).toList(),
      instructions: instructions,
      shared: shared,
    );
  }

  // Add the copyWith method
  RecipeModel copyWith({
    String? name,
    String? cuisine,
    List<ItemModel>? ingredients,
    List<String>? instructions,
    DateTime? timestamp,
    bool? shared,
  }) {
    return RecipeModel(
      name: name ?? this.name,
      cuisine: cuisine ?? this.cuisine,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      shared: shared ?? this.shared,
    );
  }
}
