import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_fridge/features/auth/domain/entities/user.dart';
import 'package:smart_fridge/features/auth/domain/usecases/check_token_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/login_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:smart_fridge/features/auth/domain/usecases/signup_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/delete_user_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/logout_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/update_password_use_case.dart';
import 'package:smart_fridge/features/auth/domain/usecases/change_name_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final LogoutUseCase logoutUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final ChangeNameUseCase changeNameUseCase;
  final SignInWithGoogle signInWithGoogle;
  final CheckTokenUseCase checkTokenUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.signupUseCase,
    required this.deleteUserUseCase,
    required this.logoutUseCase,
    required this.resetPasswordUseCase,
    required this.updatePasswordUseCase,
    required this.changeNameUseCase,
    required this.signInWithGoogle,
    required this.checkTokenUseCase,
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
    on<SignInWithGoogleEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        final user = await signInWithGoogle();
        emit(AuthLoaded(user));
      } catch (e) {
        emit(AuthError('Failed to login with Google'));
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

    on<ResetPasswordEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await resetPasswordUseCase(event.email);
        emit(AuthResetPassword());
      } catch (e) {
        emit(AuthError('Failed to reset password'));
      }
    });

    on<UpdatePasswordEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await updatePasswordUseCase(event.newPassword);
        emit(AuthUpdatedPassword());
      } catch (e) {
        emit(AuthError('Failed to update password'));
      }
    });

    on<ChangeNameEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await changeNameUseCase(event.newName);
        emit(AuthChangedName());
      } catch (e) {
        emit(AuthError('Failed to change name'));
      }
    });

    on<CheckUserTokenEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        final user = await checkTokenUseCase();
        if (user == null) {
          emit(AuthInitial());
        }
        emit(AuthLoaded(user!));
      } catch (e) {
        emit(AuthError(e.toString()));
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
