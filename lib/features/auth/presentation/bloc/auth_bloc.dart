import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_fridge/features/auth/domain/entities/user.dart';
import 'package:smart_fridge/features/auth/domain/usecases/login_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/signup_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/delete_user_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/logout_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.signupUseCase,
    required this.deleteUserUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        final user = await loginUseCase(event.email, event.password);
        emit(AuthLoaded(user));
      } catch (e) {
        emit(AuthError('Failed to login'));
      }
    });

    on<SignupEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        final user =
            await signupUseCase(event.email, event.password, event.displayName);
        emit(AuthLoaded(user));
      } catch (e) {
        emit(AuthError('Failed to signup'));
      }
    });

    on<DeleteUserEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await deleteUserUseCase();
        emit(AuthDeleted());
      } catch (e) {
        emit(AuthError('Failed to delete user'));
      }
    });

    on<LogoutEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await logoutUseCase();
        emit(AuthLoggedOut());
      } catch (e) {
        emit(AuthError('Failed to logout'));
      }
    });
  }
}
