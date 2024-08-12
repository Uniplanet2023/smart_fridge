import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:smart_fridge/core/error/failures.dart';
import 'package:smart_fridge/features/recipes/domain/entities/video_upload_result.dart';

abstract class VideoRepository {
  Future<Either<Failure, VideoUploadResult>> uploadVideo(File video);
}
