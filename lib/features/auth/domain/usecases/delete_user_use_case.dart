import 'package:smart_fridge/features/auth/domain/repository/auth_repository.dart';

class DeleteUserUseCase {
  final AuthRepository repository;

  DeleteUserUseCase(this.repository);

  Future<void> call() async {
    return await repository.deleteUser();
  }
}
