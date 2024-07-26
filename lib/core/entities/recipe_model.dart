// import 'package:isar/isar.dart';
// import 'package:smart_fridge/core/entities/item.dart';
// import 'dart:convert';

// part 'recipe.g.dart'; // Required for code generation

// @Collection()
// class RecipeModel {
//   Id id = Isar.autoIncrement; // Auto increment ID

//   @Index()
//   late String name;
//   late String cuisine;
//   late List<String> instructions;
//   final ingredients =
//       IsarLinks<Item>(); // Using IsarLinks to manage relationship
//   late bool shared;

//   RecipeModel({
//     required this.name,
//     required this.cuisine,
//     required this.instructions,
//     required List<Item> ingredients,
//     required this.shared,
//   }) {
//     this.ingredients.addAll(ingredients);
//   }

//   factory RecipeModel.fromJson(Map<String, dynamic> json) {
//     return RecipeModel(
//       name: json['name'] as String? ?? '',
//       cuisine: json['cuisine'] as String? ?? '',
//       instructions:
//           (json['instructions'] as List).map((e) => e as String).toList(),
//       ingredients: (json['ingredients'] as List)
//           .map((e) => Item.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       shared: json['shared'] as bool? ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'cuisine': cuisine,
//       'instructions': instructions,
//       'ingredients': ingredients.map((e) => e.toJson()).toList(),
//       'shared': shared
//     };
//   }

//   // Add the copyWith method
//   RecipeModel copyWith({
//     Id? id,
//     String? name,
//     String? cuisine,
//     List<Item>? ingredients,
//     List<String>? instructions,
//     bool? shared,
//   }) {
//     final newRecipe = RecipeModel(
//       name: name ?? this.name,
//       cuisine: cuisine ?? this.cuisine,
//       instructions: instructions ?? this.instructions,
//       ingredients: ingredients ?? this.ingredients.toList(),
//       shared: shared ?? this.shared,
//     );
//     newRecipe.id = this.id;
//     return newRecipe;
//   }
// }
