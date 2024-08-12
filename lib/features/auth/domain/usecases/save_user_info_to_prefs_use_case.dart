import 'package:smart_fridge/features/auth/domain/entities/user.dart';
import 'package:smart_fridge/features/auth/domain/repository/auth_repository.dart';

class SaveUserInfoToPrefsUseCase {
  final AuthRepository repository;

  SaveUserInfoToPrefsUseCase(this.repository);

   Future<void> call(User user) {
    return repository.saveUserToPrefs(user);
  }
}
