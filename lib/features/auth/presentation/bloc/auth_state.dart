part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  late final User? user;
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  @override
  final User user;

  AuthLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthDeleted extends AuthState {}

class AuthLoggedOut extends AuthState {}

class AuthResetPassword extends AuthState {}

class AuthUpdatedPassword extends AuthState {}

class AuthChangedName extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
