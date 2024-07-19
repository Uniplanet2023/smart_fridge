part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInWithGoogleEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;
  final String displayName;

  SignupEvent(this.email, this.password, this.displayName);

  @override
  List<Object?> get props => [email, password, displayName];
}

class DeleteUserEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  ResetPasswordEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class UpdatePasswordEvent extends AuthEvent {
  final String email;
  final String password;
  final String newPassword;

  UpdatePasswordEvent(this.email, this.password, this.newPassword);

  @override
  List<Object?> get props => [newPassword];
}

class ChangeNameEvent extends AuthEvent {
  final String newName;

  ChangeNameEvent(this.newName);

  @override
  List<Object?> get props => [newName];
}

class CheckUserTokenEvent extends AuthEvent {}
