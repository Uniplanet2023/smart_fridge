import 'package:smart_fridge/features/auth/domain/repository/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<void> call(String email) async {
    return await repository.resetPassword(email);
  }
}
