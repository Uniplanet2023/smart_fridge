// domain/repositories/profile_repository.dart

import 'dart:io';

abstract class ProfileRepository {
  Future<String> uploadProfileImage(File image, String userId);
}
