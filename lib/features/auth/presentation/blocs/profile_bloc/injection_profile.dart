import 'package:get_it/get_it.dart';
import 'package:smart_fridge/features/auth/data/repository/profile_repository_impl.dart';
import 'package:smart_fridge/features/auth/domain/repository/profile_repository.dart';
import 'package:smart_fridge/features/auth/domain/usecases/upload_profile_image_usecase.dart';
import 'package:smart_fridge/features/auth/presentation/blocs/profile_bloc/profile_bloc.dart';

import '../../../../../core/helper/firebase_storage_helper.dart';

final GetIt serviceLocator = GetIt.instance;

void initProfile() async {
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
          uploadProfileImageUseCase:
              serviceLocator<UploadProfileImageUseCase>(),
        ));
}
