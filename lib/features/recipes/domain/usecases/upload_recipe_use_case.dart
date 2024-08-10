import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:smart_fridge/core/domain_layer_entities/recipe.dart';
import 'package:smart_fridge/core/domain_layer_entities/save_recipe.dart';
import 'package:smart_fridge/core/error/failures.dart';
import 'package:smart_fridge/features/recipes/domain/entities/shared_recipe.dart';
import 'package:smart_fridge/features/recipes/domain/repository/recipe_repository.dart';
import 'package:smart_fridge/features/recipes/domain/repository/video_repository.dart';

class UploadRecipeUseCase {
  final RecipeRepository recipeRepository;
  final VideoRepository videoRepository;

  UploadRecipeUseCase({
    required this.recipeRepository,
    required this.videoRepository,
  });

  Future<Either<Failure, void>> call({
    required SaveRecipe recipe,
    required File videoFile,
  }) async {
    // Upload the video
    final videoUploadResult = await videoRepository.uploadVideo(videoFile);

    return videoUploadResult.fold(
      (failure) => Left(failure),
      (result) async {
        // Save the recipe in the database
        await recipeRepository.saveRecipeOnFirebase(recipe, result.downloadUrl);
        return const Right(null);
      },
    );
  }
}
