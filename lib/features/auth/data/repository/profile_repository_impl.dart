// data/repositories/profile_repository_impl.dart

import 'dart:io';
import 'package:smart_fridge/core/helper/firebase_storage_helper.dart';
import 'package:smart_fridge/features/auth/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final FirebaseStorageService firebaseStorageService;

  ProfileRepositoryImpl({required this.firebaseStorageService});

  @override
  Future<String> uploadProfileImage(File image, String userId) {
    return firebaseStorageService.uploadProfileImage(image, userId);
  }
}
