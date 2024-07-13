import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.userId,
    required super.name,
    required super.email,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return UserModel(
      userId: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );
  }
}
