import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/features/recipe_generation/data/data_sources/recipe_local_data_source.dart';
import 'package:smart_fridge/features/recipe_generation/data/data_sources/recipe_remote_data_source.dart';
import 'package:smart_fridge/features/recipe_generation/data/repository/recipe_repository_impl.dart';
import 'package:smart_fridge/features/recipe_generation/domain/repository/recipe_generation_repository.dart';
import 'package:smart_fridge/features/recipe_generation/domain/usecases/generate_recipe_use_case.dart';
import 'package:smart_fridge/features/recipe_generation/domain/usecases/save_recipe_use_case.dart';
import 'package:smart_fridge/features/recipe_generation/presentation/bloc/bloc/recipe_generation_bloc.dart';

Future<void> initGeneratingRecipe() async {
  serviceLocator
    // Data sources
    ..registerFactory<RecipeRemoteDataSource>(() => RecipeRemoteDataSource())
    ..registerFactory<RecipeLocalDataSource>(() => RecipeLocalDataSource())
    // Repositories
    ..registerFactory<RecipeRepository>(
      () => RecipeRepositoryImpl(
        serviceLocator<RecipeRemoteDataSource>(),
        serviceLocator<RecipeLocalDataSource>(),
      ),
    )
    // Use cases
    ..registerFactory(
        () => GenerateRecipeUseCase(serviceLocator<RecipeRepository>()))
    ..registerFactory(
        () => SaveRecipeUseCase(serviceLocator<RecipeRepository>()))
    // Blocs
    ..registerLazySingleton(() => RecipeGenerationBloc(
          generateRecipeUseCase: serviceLocator<GenerateRecipeUseCase>(),
          saveRecipeUseCase: serviceLocator<SaveRecipeUseCase>(),
        ));
}
