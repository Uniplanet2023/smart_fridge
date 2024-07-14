import 'package:smart_fridge/features/auth/domain/repository/auth_repository.dart';
import 'package:smart_fridge/features/auth/domain/entities/user.dart';

class CheckTokenUseCase {
  final AuthRepository repository;

  CheckTokenUseCase(this.repository);

  Future<User?> call() async {
    return await repository.checkUserTokenExists();
  }
}
