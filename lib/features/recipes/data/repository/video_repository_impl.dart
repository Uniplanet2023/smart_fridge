import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_fridge/core/error/failures.dart';
import 'package:smart_fridge/features/recipes/domain/entities/video_upload_result.dart';
import 'package:smart_fridge/features/recipes/domain/repository/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  final FirebaseStorage firebaseStorage;

  VideoRepositoryImpl({required this.firebaseStorage});

  @override
  Future<Either<Failure, VideoUploadResult>> uploadVideo(File video) async {
    try {
      final fileName = video.path.split('/').last;
      final ref = firebaseStorage.ref().child('videos/$fileName');
      final uploadTask = ref.putFile(video);
      final taskSnapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return Right(
          VideoUploadResult(downloadUrl: downloadUrl, fileName: fileName));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
