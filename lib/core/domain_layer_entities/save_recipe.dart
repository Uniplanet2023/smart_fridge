class SaveRecipe {
  final int? id;
  final String name;
  final String cuisine;
  final List<String> instructions;
  final List<String> ingredients;
  final bool shared;

  SaveRecipe({
    this.id,
    required this.name,
    required this.cuisine,
    required this.instructions,
    required this.ingredients,
    required this.shared,
  });

  SaveRecipe copyWith({
    int? id,
    String? name,
    String? cuisine,
    List<String>? instructions,
    List<String>? ingredients,
    bool? shared,
  }) {
    return SaveRecipe(
      id: id ?? this.id,
      name: name ?? this.name,
      cuisine: cuisine ?? this.cuisine,
      instructions: instructions ?? this.instructions,
      ingredients: ingredients ?? this.ingredients,
      shared: shared ?? this.shared,
    );
  }
}
