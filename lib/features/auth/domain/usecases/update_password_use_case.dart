import 'package:smart_fridge/features/auth/domain/repository/auth_repository.dart';

class UpdatePasswordUseCase {
  final AuthRepository repository;

  UpdatePasswordUseCase(this.repository);

  Future<void> call(String newPassword) async {
    return await repository.updatePassword(newPassword);
  }
}
