import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_fridge/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:smart_fridge/features/auth/data/repository/auth_repository_impl.dart';
import 'package:smart_fridge/features/auth/domain/repository/auth_repository.dart';
import 'package:smart_fridge/features/auth/domain/usecases/change_name_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/delete_user_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/login_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/logout_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:smart_fridge/features/auth/domain/usecases/signup_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/update_password_use_case.dart';
import 'package:smart_fridge/features/auth/presentation/bloc/auth_bloc.dart';

class AuthInjection {
  static Future<void> init(GetIt serviceLocator) async {
    // Register FirebaseAuth instance
    serviceLocator.registerLazySingleton<FirebaseAuth>(
      () => FirebaseAuth.instance,
    );

    // Register FirebaseFirestore instance
    serviceLocator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );

    // Register AuthRemoteDataSource
    serviceLocator.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        firebaseAuth: serviceLocator<FirebaseAuth>(),
        firestore: serviceLocator<FirebaseFirestore>(),
      ),
    );

    // Register AuthRepository
    serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator<AuthRemoteDataSource>(),
      ),
    );

    // Register Login UseCase
    serviceLocator.registerFactory(
      () => LoginUseCase(serviceLocator()),
    );

    // Register signup UseCase
    serviceLocator.registerFactory(
      () => SignupUseCase(serviceLocator()),
    );

    // Register delete user UseCase
    serviceLocator.registerFactory(
      () => DeleteUserUseCase(serviceLocator()),
    );

    // Register delete user UseCase
    serviceLocator.registerFactory(
      () => LogoutUseCase(serviceLocator()),
    );

    serviceLocator.registerFactory(
      () => ResetPasswordUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory(
      () => UpdatePasswordUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory(
      () => ChangeNameUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory(
      () => SignInWithGoogle(serviceLocator()),
    );
    // Register a single instance of AuthBloc
    serviceLocator.registerLazySingleton(
      () => AuthBloc(
        loginUseCase: serviceLocator(),
        signupUseCase: serviceLocator(),
        deleteUserUseCase: serviceLocator(),
        logoutUseCase: serviceLocator(),
        resetPasswordUseCase: serviceLocator(),
        updatePasswordUseCase: serviceLocator(),
        changeNameUseCase: serviceLocator(),
        signInWithGoogle: serviceLocator(),
      ),
    );
  }
}
