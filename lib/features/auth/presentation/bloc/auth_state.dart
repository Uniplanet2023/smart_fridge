part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final User user;
  const AuthState({required this.user});
  @override
  List<Object?> get props => [user];
}

class AuthInitial extends AuthState {
  const AuthInitial()
      : super(user: const User(userId: '', name: '', email: ''));
}

class AuthLoading extends AuthState {
  const AuthLoading(User user) : super(user: user);

  @override
  List<Object?> get props => [user];
}

class AuthLoaded extends AuthState {
  const AuthLoaded(User user) : super(user: user);

  @override
  List<Object?> get props => [user];
}

class AuthDeleted extends AuthState {
  const AuthDeleted(User user) : super(user: user);

  @override
  List<Object?> get props => [user];
}

class AuthLoggedOut extends AuthState {
  const AuthLoggedOut(User user) : super(user: user);

  @override
  List<Object?> get props => [user];
}

class AuthResetPassword extends AuthState {
  const AuthResetPassword(User user) : super(user: user);

  @override
  List<Object?> get props => [user];
}

class AuthUpdatedPassword extends AuthState {
  const AuthUpdatedPassword(User user) : super(user: user);

  @override
  List<Object?> get props => [user];
}

class AuthChangedName extends AuthState {
  const AuthChangedName(User user) : super(user: user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message,
      {super.user = const User(userId: '', name: '', email: '')});

  @override
  List<Object?> get props => [message];
}
