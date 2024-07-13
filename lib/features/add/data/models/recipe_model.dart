import '../../domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  const RecipeModel({
    required super.id,
    required super.name,
    required super.description,
    required super.instructions,
    required super.timestamp,
    required super.country,
    required super.shared,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      instructions: json['instructions'],
      timestamp: DateTime.parse(json['timestamp']),
      country: json['country'],
      shared: json['shared'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'instructions': instructions,
      'timestamp': timestamp.toIso8601String(),
      'country': country,
      'shared': shared,
    };
  }
}
