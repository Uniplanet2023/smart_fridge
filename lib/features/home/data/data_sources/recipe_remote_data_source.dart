import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_fridge/core/error/exceptions.dart';
import 'package:smart_fridge/features/home/data/models/shared_recipe.dart';

abstract class SharedRecipeRemoteDataSource {
  Future<List<SharedRecipe>> fetchRecipes();
  Future<void> deleteRecipe(String recipeId);
  Future<void> updateRecipe(SharedRecipe recipe);
  Future<void> likeSharedRecipe(String recipeId, String userId);
}

class SharedRecipeRemoteDataSourceImpl implements SharedRecipeRemoteDataSource {
  final FirebaseFirestore firestore;

  SharedRecipeRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<SharedRecipe>> fetchRecipes() async {
    try {
      final snapshot = await firestore.collection('recipes').get();
      return snapshot.docs.map((doc) {
        return SharedRecipe(
          userId: doc['userId'],
          name: doc['name'],
          ingredients: List<String>.from(doc['ingredients']),
          instructions: List<String>.from(doc['instructions']),
          cuisine: doc['cuisine'],
          videoUrl: doc['videoUrl'],
          likes: List<String>.from(doc['likes']),
        );
      }).toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteRecipe(String recipeId) async {
    try {
      await firestore.collection('recipes').doc(recipeId).delete();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateRecipe(SharedRecipe recipe) async {
    try {
      await firestore.collection('recipes').doc(recipe.userId).update({
        'name': recipe.name,
        'ingredients': recipe.ingredients,
        'instructions': recipe.instructions,
        'cuisine': recipe.cuisine,
        'videoUrl': recipe.videoUrl,
        'likes': recipe.likes,
      });
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> likeSharedRecipe(String recipeId, String userId) async {
    final docRef = firestore.collection('recipes').doc(recipeId);

    await firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        throw Exception("Recipe not found");
      }

      List<String> likes = List.from(snapshot.get('likes'));

      if (likes.contains(userId)) {
        likes.remove(userId);
      } else {
        likes.add(userId);
      }

      transaction.update(docRef, {'likes': likes});
    });
  }
}
