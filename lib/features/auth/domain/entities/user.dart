import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String? profilePicture;

  const User({
    required this.userId,
    required this.name,
    required this.email,
    this.profilePicture,
  });

  @override
  List<Object?> get props => [userId, name, email];
  // Copy with method
  User copyWith({
    String? userId,
    String? name,
    String? email,
    String? profilePicture,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
