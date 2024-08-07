import 'package:get_it/get_it.dart';
import 'package:smart_fridge/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:smart_fridge/features/profile/domain/repositories/profile_repository.dart';
import 'package:smart_fridge/features/profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:smart_fridge/features/profile/presentation/bloc/profile_bloc.dart';

import '../../../../core/helper/firebase_storage_helper.dart';

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
