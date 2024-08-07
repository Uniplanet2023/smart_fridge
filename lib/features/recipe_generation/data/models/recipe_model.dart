// data/models/recipe_model.dart

import 'package:isar/isar.dart';
import 'package:smart_fridge/core/entities/recipe.dart';
import 'package:smart_fridge/core/isar_models/item.dart';

part 'recipe_model.g.dart';

@Collection()
class RecipeModel {
  Id id = Isar.autoIncrement; // Auto increment ID

  @Index()
  late String name;
  late String cuisine;

  late List<String> instructions;
  late List<String> ingredients; // Storing item names as strings
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
      ingredients:
          (json['ingredients'] as List).map((e) => e as String).toList(),
      instructions:
          (json['instructions'] as List).map((e) => e as String).toList(),
      shared: json['shared'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cuisine': cuisine,
      'instructions': instructions,
      'ingredients': ingredients,
      'shared': shared,
    };
  }

  RecipeModel copyWith({
    Id? id,
    String? name,
    String? cuisine,
    List<String>? ingredients,
    List<String>? instructions,
    bool? shared,
  }) {
    return RecipeModel(
      name: name ?? this.name,
      cuisine: cuisine ?? this.cuisine,
      instructions: instructions ?? this.instructions,
      shared: shared ?? this.shared,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  Recipe toDomain(List<Item> items) {
    return Recipe(
      name: name,
      cuisine: cuisine,
      instructions: instructions,
      ingredients: items,
      shared: shared,
    );
  }

  factory RecipeModel.fromDomain(Recipe recipe) {
    return RecipeModel(
      name: recipe.name,
      cuisine: recipe.cuisine,
      instructions: recipe.instructions,
      ingredients: recipe.ingredients.map((item) => item.name).toList(),
      shared: recipe.shared,
    );
  }
}
