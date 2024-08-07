import 'dart:io';

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
  }) : super(const AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      try {
        emit(AuthLoading(state.user));
        final user = await loginUseCase(event.email, event.password);
        emit(AuthLoaded(user));
      } catch (e) {
        emit(const AuthError('Login failed. Please check your credentials.'));
      }
    });
    on<SignInWithGoogleEvent>((event, emit) async {
      try {
        emit(AuthLoading(state.user));
        final user = await signInWithGoogle();
        emit(AuthLoaded(user));
      } catch (e) {
        emit(const AuthError('Failed to login with Google'));
      }
    });

    on<SignupEvent>((event, emit) async {
      try {
        emit(AuthLoading(state.user));
        final user =
            await signupUseCase(event.email, event.password, event.displayName);
        emit(AuthLoaded(user));
      } catch (e) {
        emit(const AuthError('Failed to signup'));
      }
    });

    on<DeleteUserEvent>((event, emit) async {
      try {
        emit(AuthLoading(state.user));
        await deleteUserUseCase();
        emit(AuthDeleted(state.user));
      } catch (e) {
        emit(const AuthError('Failed to delete user'));
      }
    });

    on<LogoutEvent>((event, emit) async {
      try {
        emit(AuthLoading(state.user));
        await logoutUseCase();
        emit(AuthLoggedOut(state.user));
      } catch (e) {
        emit(const AuthError('Failed to logout'));
      }
    });

    on<ResetPasswordEvent>((event, emit) async {
      try {
        emit(AuthLoading(state.user));
        await resetPasswordUseCase(event.email);
        emit(AuthResetPassword(state.user));
      } catch (e) {
        emit(const AuthError('Failed to reset password'));
      }
    });

    on<UpdatePasswordEvent>((event, emit) async {
      try {
        emit(AuthLoading(state.user));
        await updatePasswordUseCase(
            event.email, event.password, event.newPassword);
        emit(AuthUpdatedPassword(state.user));
      } catch (e) {
        emit(const AuthError('Failed to update password'));
      }
    });

    on<ChangeNameEvent>((event, emit) async {
      try {
        emit(AuthLoading(state.user));
        await changeNameUseCase(event.newName);
        User newUser = state.user.copyWith(name: event.newName);
        emit(AuthChangedName(newUser));
      } catch (e) {
        emit(const AuthError('Failed to change name'));
      }
    });

    on<CheckUserTokenEvent>((event, emit) async {
      try {
        emit(AuthLoading(state.user));
        final user = await checkTokenUseCase();
        if (user == null) {
          emit(const AuthInitial());
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
