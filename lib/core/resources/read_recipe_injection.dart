import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_fridge/features/recipe_generation/data/data_sources/gemini_data_source.dart';
import 'package:smart_fridge/features/recipe_generation/data/repository/gemini_repository_impl.dart';
import 'package:smart_fridge/features/recipe_generation/data/repository/image_repository_impl.dart';
import 'package:smart_fridge/features/recipe_generation/domain/repository/gemini_repository.dart';
import 'package:smart_fridge/features/recipe_generation/domain/repository/image_repository.dart';
import 'package:smart_fridge/features/recipe_generation/domain/usecases/read_receipt.dart';
import 'package:smart_fridge/features/recipe_generation/domain/usecases/upload_image.dart';
import 'package:smart_fridge/features/recipe_generation/presentation/bloc/read_receipt_bloc.dart';

void initReadReceipt(GetIt serviceLocator) async {
  serviceLocator
    // Data sources
    ..registerFactory<ReadReceiptRemoteDataSource>(
        () => RecipeRemoteDataSourceImpl())
    // Repository
    ..registerFactory<ReadReceiptRepository>(
      () => ReadReceiptRepositoryImpl(
        serviceLocator<ReadReceiptRemoteDataSource>(),
      ),
    )
    ..registerFactory<ImageRepository>(
      () => ImageRepositoryImpl(
        firebaseStorage: serviceLocator<FirebaseStorage>(),
      ),
    )
    // use cases
    ..registerFactory(
        () => ReadReceipt(serviceLocator<ReadReceiptRepository>()))
    ..registerFactory(() => UploadImage(serviceLocator<ImageRepository>()))
    // Bloc
    ..registerLazySingleton<ReadReceiptBloc>(() => ReadReceiptBloc(
        readReceipt: serviceLocator<ReadReceipt>(),
        uploadImage: serviceLocator<UploadImage>()));
}
