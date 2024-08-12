import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.userId,
    required super.name,
    required super.email,
    super.profilePicture,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return UserModel(
      userId: doc.id,
      name: data['displayName'] ?? '',
      email: data['email'] ?? '',
      profilePicture: data['profilePicture'],
    );
  }

  // Convert UserModel to JSON string
  String toJson() {
    final Map<String, dynamic> data = {
      'userId': userId,
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
    };
    return json.encode(data);
  }

  // Create a UserModel from JSON string
  factory UserModel.fromJson(String source) {
    final Map<String, dynamic> data = json.decode(source);
    return UserModel(
      userId: data['userId'],
      name: data['name'],
      email: data['email'],
      profilePicture: data['profilePicture'],
    );
  }

  // Convert UserModel to User (domain layer)
  User toDomain() {
    return User(
      userId: userId,
      name: name,
      email: email,
      profilePicture: profilePicture,
    );
  }

  // Create a UserModel from a User (domain layer)
  factory UserModel.fromDomain(User user) {
    return UserModel(
      userId: user.userId,
      name: user.name,
      email: user.email,
      profilePicture: user.profilePicture,
    );
  }
}
