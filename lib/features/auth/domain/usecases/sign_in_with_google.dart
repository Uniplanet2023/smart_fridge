// lib/features/auth/domain/usecases/sign_in_with_google.dart
import 'package:smart_fridge/features/auth/domain/repository/auth_repository.dart';
import '../entities/user.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<User> call() async {
    return await repository.signInWithGoogle();
  }
}
