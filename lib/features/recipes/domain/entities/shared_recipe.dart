class SharedRecipe {
  final String userId;
  final String name;
  final List<String> ingredients;
  final List<String> instructions;
  final String cuisine;
  final String pictureUrl;
  final List<String> likes;

  SharedRecipe({
    required this.userId,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.cuisine,
    required this.pictureUrl,
    required this.likes,
  });
  // copy with
  SharedRecipe copyWith({
    String? userId,
    String? name,
    List<String>? ingredients,
    List<String>? instructions,
    String? cuisine,
    String? pictureUrl,
    List<String>? likes,
  }) {
    return SharedRecipe(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      cuisine: cuisine ?? this.cuisine,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      likes: likes ?? this.likes,
    );
  }
}
