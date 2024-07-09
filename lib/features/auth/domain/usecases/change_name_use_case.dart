import 'package:smart_fridge/features/auth/domain/repository/auth_repository.dart';

class ChangeNameUseCase {
  final AuthRepository repository;

  ChangeNameUseCase(this.repository);

  Future<void> call(String newName) async {
    return await repository.changeName(newName);
  }
}
