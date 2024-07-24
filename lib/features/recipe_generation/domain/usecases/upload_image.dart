// domain/usecases/upload_image.dart

import 'dart:io';
import 'package:smart_fridge/features/recipe_generation/domain/repository/image_repository.dart';

class UploadImage {
  final ImageRepository repository;

  UploadImage(this.repository);

  Future<String> call(File image) async {
    return await repository.uploadImage(image);
  }
}
