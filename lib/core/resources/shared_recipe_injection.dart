import 'package:get_it/get_it.dart';
import 'package:smart_fridge/features/home/data/data_sources/recipe_remote_data_source.dart';
import 'package:smart_fridge/features/home/data/repository/recipe_repository_impl.dart';
import 'package:smart_fridge/features/home/domain/repositories/shared_recipe_repository.dart';
import 'package:smart_fridge/features/home/domain/usecases/delete_recipe_use_case.dart';
import 'package:smart_fridge/features/home/domain/usecases/fetch_recipes_use_case.dart';
import 'package:smart_fridge/features/home/domain/usecases/like_recipe_use_case.dart';
import 'package:smart_fridge/features/home/domain/usecases/update_recipe_use_case.dart';
import 'package:smart_fridge/features/home/presentation/blocs/shared_recipe_bloc/shared_recipe_bloc.dart';

void setupSharedRecipe(GetIt serviceLocator) {
  // Data sources
  serviceLocator.registerFactory<SharedRecipeRemoteDataSource>(
    () => SharedRecipeRemoteDataSourceImpl(firestore: serviceLocator()),
  );

  // Repositories
  serviceLocator.registerFactory<SharedRecipeRepository>(
    () => SharedRecipeRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Use cases
  serviceLocator
      .registerFactory(() => FetchSharedRecipesUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => DeleteSharedRecipeUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => UpdateSharedRecipeUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => LikeSharedRecipeUseCase(serviceLocator()));

  // Blocs
  serviceLocator.registerLazySingleton(
    () => SharedRecipeBloc(
      fetchSharedRecipeUseCase: serviceLocator(),
      deleteSharedRecipeUseCase: serviceLocator(),
      updateSharedRecipeUseCase: serviceLocator(),
      likeRecipeUseCase: serviceLocator(),
    ),
  );
}
