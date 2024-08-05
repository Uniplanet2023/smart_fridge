import 'dart:io';

import 'package:smart_fridge/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:smart_fridge/features/auth/domain/entities/user.dart';
import 'package:smart_fridge/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<User> signup(String email, String password, String displayName) async {
    return await remoteDataSource.signup(email, password, displayName);
  }

  @override
  Future<void> deleteUser() async {
    return await remoteDataSource.deleteUser();
  }

  @override
  Future<void> logout() async {
    return await remoteDataSource.logout();
  }

  @override
  Future<void> resetPassword(String email) async {
    return await remoteDataSource.resetPassword(email);
  }

  @override
  Future<void> updatePassword(
      String email, String password, String newPassword) async {
    return await remoteDataSource.updatePassword(email, password, newPassword);
  }

  @override
  Future<void> changeName(String newName) async {
    return await remoteDataSource.changeName(newName);
  }

  @override
  Future<User> signInWithGoogle() {
    return remoteDataSource.signInWithGoogle();
  }

  @override
  Future<User?> checkUserTokenExists() async {
    return remoteDataSource.checkUserTokenExists();
  }

  @override
  Future<void> updateProfilePicture(File newImage) {
    // TODO: implement updateProfilePicture
    throw UnimplementedError();
  }
}
