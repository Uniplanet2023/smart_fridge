import 'package:isar/isar.dart';
import 'package:smart_fridge/core/isar_models/item.dart';

part 'recipe_model.g.dart';

//Isar
@Collection()
class RecipeModel {
  Id id = Isar.autoIncrement; // Auto increment ID

  @Index()
  late String name;
  late String cuisine;
  late List<String> instructions; // item json format
  final String ingredients;

  late bool shared;

  RecipeModel({
    required this.name,
    required this.cuisine,
    required this.instructions,
    required this.ingredients,
    required this.shared,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    final recipe = RecipeModel(
      name: json['name'] as String? ?? '',
      cuisine: json['cuisine'] as String? ?? '',
      ingredients: json['ingredients'] as String? ?? '',
      instructions:
          (json['instructions'] as List).map((e) => e as String).toList(),
      shared: json['shared'] as bool? ?? false,
    );

    return recipe;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cuisine': cuisine,
      'instructions': instructions,
      'ingredients': ingredients,
      'shared': shared
    };
  }

  RecipeModel copyWith({
    Id? id,
    String? name,
    String? cuisine,
    List<Item>? ingredients,
    List<String>? instructions,
    bool? shared,
  }) {
    final newRecipe = RecipeModel(
      name: name ?? this.name,
      cuisine: cuisine ?? this.cuisine,
      instructions: instructions ?? this.instructions,
      shared: shared ?? this.shared,
      ingredients: this.ingredients,
    );

    return newRecipe;
  }
}
