import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String password;
  final DateTime timestamp;
  final String field;

  const User({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.timestamp,
    required this.field,
  });

  @override
  List<Object?> get props => [userId, name, email, password, timestamp, field];
}
