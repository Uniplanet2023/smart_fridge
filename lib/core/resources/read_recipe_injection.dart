import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_fridge/features/receipt_scanning/data/data_sources/gemini_data_source.dart';
import 'package:smart_fridge/features/receipt_scanning/data/repository/gemini_repository_impl.dart';
import 'package:smart_fridge/features/receipt_scanning/data/repository/image_repository_impl.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/repository/gemini_repository.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/repository/image_repository.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/usecases/read_receipt.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/usecases/upload_image.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/bloc/read_receipt_bloc.dart';

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
