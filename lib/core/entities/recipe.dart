import 'package:isar/isar.dart';

part 'recipe.g.dart'; // Required for code generation

@Collection()
class Recipe {
  Id id = Isar.autoIncrement; // Auto increment ID

  @Index()
  late String name;
  late String cuisine;
  late List<String> instructions;
  late List<String> ingredients;
  late DateTime timestamp;
  late bool shared;

  Recipe({
    required this.name,
    required this.cuisine,
    required this.instructions,
    required this.ingredients,
    required this.timestamp,
    required this.shared,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'] as String? ?? '',
      cuisine: json['cuisine'] as String? ?? '',
      ingredients: json['ingredients'] as List<String>? ?? [],
      instructions: json['instructions'] as List<String>? ?? [],
      timestamp: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'] as String)
          : DateTime.now(),
      shared: json['shared'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cuisine': cuisine,
      'ingredients': ingredients,
      'instructions': instructions,
      'timestamp': timestamp.toIso8601String(),
      'shared': shared
    };
  }

  // Add the copyWith method
  Recipe copyWith({
    Id? id,
    String? name,
    String? cuisine,
    List<String>? ingredients,
    List<String>? instructions,
    DateTime? timestamp,
    bool? shared,
  }) {
    return Recipe(
      name: name ?? this.name,
      cuisine: cuisine ?? this.cuisine,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      timestamp: timestamp ?? this.timestamp,
      shared: shared ?? this.shared,
    );
  }
}
