import 'package:smart_fridge/core/domain_layer_entities/item.dart';

// Model used for Recipe generation - domain and presentation layer
class Recipe {
  final String name;
  final String cuisine;
  final List<String> instructions;
  final List<Item> ingredients;
  final bool shared;

  Recipe({
    required this.name,
    required this.cuisine,
    required this.instructions,
    required this.ingredients,
    required this.shared,
  });

  Recipe copyWith({
    String? name,
    String? cuisine,
    List<Item>? ingredients,
    List<String>? instructions,
    bool? shared,
  }) {
    return Recipe(
      name: name ?? this.name,
      cuisine: cuisine ?? this.cuisine,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      shared: shared ?? this.shared,
    );
  }
}
