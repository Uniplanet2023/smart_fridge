import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_fridge/features/recipes/data/data_sources/recipe_local_data_source.dart';
import 'package:smart_fridge/features/recipes/data/repository/recipe_repository_impl.dart';
import 'package:smart_fridge/features/recipes/data/repository/video_repository_impl.dart';
import 'package:smart_fridge/features/recipes/domain/repository/recipe_repository.dart';
import 'package:smart_fridge/features/recipes/domain/repository/video_repository.dart';
import 'package:smart_fridge/features/recipes/domain/usecases/delete_recipes_use_case.dart';
import 'package:smart_fridge/features/recipes/domain/usecases/fetch_recipes_use_case.dart';
import 'package:smart_fridge/features/recipes/domain/usecases/search_recipes_use_case.dart';
import 'package:smart_fridge/features/recipes/domain/usecases/upload_recipe_use_case.dart';
import 'package:smart_fridge/features/recipes/presentation/bloc/recipe_bloc.dart';

void setupRecipe(GetIt serviceLocator) {
  // Register Data Sources
  serviceLocator
      .registerFactory<RecipeLocalDataSource>(() => RecipeLocalDataSource());

  // Register Repositories
  serviceLocator.registerFactory<RecipeRepository>(
    () => RecipeRepositoryImpl(
      localDataSource: serviceLocator<RecipeLocalDataSource>(),
      firestore: serviceLocator<FirebaseFirestore>(),
    ),
  );
  serviceLocator.registerFactory<VideoRepository>(
    () =>
        VideoRepositoryImpl(firebaseStorage: serviceLocator<FirebaseStorage>()),
  );

  // Register Use Cases
  serviceLocator.registerFactory(
      () => FetchRecipesUseCase(serviceLocator<RecipeRepository>()));
  serviceLocator.registerFactory(
      () => SearchRecipesUseCase(serviceLocator<RecipeRepository>()));
  serviceLocator.registerFactory(
      () => DeleteRecipesUseCase(serviceLocator<RecipeRepository>()));
  serviceLocator.registerFactory<UploadRecipeUseCase>(
    () => UploadRecipeUseCase(
      videoRepository: serviceLocator<VideoRepository>(),
      recipeRepository: serviceLocator<RecipeRepository>(),
    ),
  );
  // Register Blocs
  serviceLocator.registerLazySingleton(() => RecipeBloc(
        fetchRecipesUseCase: serviceLocator<FetchRecipesUseCase>(),
        searchRecipesUseCase: serviceLocator<SearchRecipesUseCase>(),
        deleteRecipesUseCase: serviceLocator<DeleteRecipesUseCase>(),
        uploadRecipeUseCase: serviceLocator<UploadRecipeUseCase>(),
      ));
}
