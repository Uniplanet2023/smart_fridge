import 'dart:io';

import 'package:smart_fridge/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> signup(String email, String password, String displayName);
  Future<void> deleteUser();
  Future<void> logout();
  Future<void> resetPassword(String email);
  Future<void> updatePassword(
      String email, String password, String newPassword);
  Future<void> changeName(String newName);
  Future<User> signInWithGoogle();
  Future<User?> checkUserTokenExists();
  Future<void> updateProfilePicture(File newImage);
}
