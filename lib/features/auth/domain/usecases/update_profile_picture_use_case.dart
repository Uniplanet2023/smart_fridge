import 'dart:io';

import 'package:smart_fridge/features/auth/domain/repository/auth_repository.dart';

class UpdateProfilePictureUseCase {
  final AuthRepository repository;

  UpdateProfilePictureUseCase(this.repository);

  Future<void> call(File image) async {
    return await repository.updateProfilePicture(image);
  }
}
