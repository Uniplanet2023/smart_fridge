import 'package:isar/isar.dart';
import 'package:smart_fridge/core/domain_layer_entities/save_recipe.dart';

part 'save_recipe_model.g.dart';

// For saving recipes - Data layer
@Collection()
class SaveRecipeModel {
  Id id = Isar.autoIncrement; // Auto increment ID

  @Index()
  late String name;
  late String cuisine;
  late List<String> instructions;
  late List<String> ingredients; // Storing item names as strings
  late bool shared;

  SaveRecipeModel({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.cuisine,
    required this.instructions,
    required this.ingredients,
    required this.shared,
  });

  factory SaveRecipeModel.fromJson(Map<String, dynamic> json) {
    return SaveRecipeModel(
      id: json['id'] != null ? json['id'] as int : Isar.autoIncrement,
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
      'id': id,
      'name': name,
      'cuisine': cuisine,
      'instructions': instructions,
      'ingredients': ingredients,
      'shared': shared,
    };
  }

  SaveRecipeModel copyWith({
    Id? id,
    String? name,
    String? cuisine,
    List<String>? ingredients,
    List<String>? instructions,
    bool? shared,
  }) {
    return SaveRecipeModel(
      name: name ?? this.name,
      cuisine: cuisine ?? this.cuisine,
      instructions: instructions ?? this.instructions,
      shared: shared ?? this.shared,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  SaveRecipe toDomain() {
    return SaveRecipe(
      id: id,
      name: name,
      cuisine: cuisine,
      instructions: instructions,
      ingredients: ingredients,
      shared: shared,
    );
  }

  factory SaveRecipeModel.fromDomain(SaveRecipe recipe) {
    return SaveRecipeModel(
      id: recipe.id ?? Isar.autoIncrement,
      name: recipe.name,
      cuisine: recipe.cuisine,
      instructions: recipe.instructions,
      ingredients: recipe.ingredients,
      shared: recipe.shared,
    );
  }
}
