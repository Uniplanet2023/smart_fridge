import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_fridge/features/auth/domain/entities/user.dart';
import 'package:smart_fridge/features/auth/domain/usecases/login_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/signup_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/delete_user_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/logout_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;
  final DeleteUserUseCase _deleteUserUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required SignupUseCase signupUseCase,
    required DeleteUserUseCase deleteUserUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _loginUseCase = loginUseCase,
        _signupUseCase = signupUseCase,
        _deleteUserUseCase = deleteUserUseCase,
        _logoutUseCase = logoutUseCase,
        super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        final user = await _loginUseCase(event.email, event.password);
        emit(AuthLoaded(user));
      } catch (e) {
        emit(AuthError('Failed to login'));
      }
    });

    on<SignupEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        final user = await _signupUseCase(
            event.email, event.password, event.displayName);
        emit(AuthLoaded(user));
      } catch (e) {
        emit(AuthError('Failed to signup'));
      }
    });

    on<DeleteUserEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await _deleteUserUseCase();
        emit(AuthDeleted());
      } catch (e) {
        emit(AuthError('Failed to delete user'));
      }
    });

    on<LogoutEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await _logoutUseCase();
        emit(AuthLoggedOut());
      } catch (e) {
        emit(AuthError('Failed to logout'));
      }
    });
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
