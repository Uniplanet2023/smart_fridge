// domain/usecases/upload_profile_image_usecase.dart

import 'dart:io';
import '../repositories/profile_repository.dart';

class UploadProfileImageUseCase {
  final ProfileRepository repository;

  UploadProfileImageUseCase(this.repository);

  Future<String> call(File image, String userId) {
    return repository.uploadProfileImage(image, userId);
  }
}
