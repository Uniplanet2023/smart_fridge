import 'package:get_it/get_it.dart';
import 'package:smart_fridge/features/auth/data/repository/profile_repository_impl.dart';
import 'package:smart_fridge/features/auth/domain/repository/profile_repository.dart';
import 'package:smart_fridge/features/auth/domain/usecases/upload_profile_image_usecase.dart';
import 'package:smart_fridge/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:smart_fridge/features/auth/presentation/blocs/profile_bloc/profile_bloc.dart';

import '../helper/firebase_storage_helper.dart';

void initProfile(GetIt serviceLocator) async {
  serviceLocator
    // Repository
    ..registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(
          firebaseStorageService: FirebaseStorageService()),
    )
    // use cases
    ..registerFactory(
        () => UploadProfileImageUseCase(serviceLocator<ProfileRepository>()))
    // Bloc
    ..registerLazySingleton<ProfileBloc>(() => ProfileBloc(
          authBloc: serviceLocator<AuthBloc>(),
          uploadProfileImageUseCase:
              serviceLocator<UploadProfileImageUseCase>(),
        ));
}
