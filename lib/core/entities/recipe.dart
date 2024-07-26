import 'package:smart_fridge/core/entities/item.dart';

class Recipe {
  late String name;
  late String cuisine;
  late List<String> instructions;
  late List<Item> ingredients;
  late bool shared;

  Recipe({
    required this.name,
    required this.cuisine,
    required this.instructions,
    required this.ingredients,
    required this.shared,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'] as String? ?? '',
      cuisine: json['cuisine'] as String? ?? '',
      ingredients: (json['ingredients'] as List)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
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

  // Add the copyWith method
  Recipe copyWith({
    String? name,
    String? cuisine,
    List<Item>? ingredients,
    List<String>? instructions,
    DateTime? timestamp,
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
