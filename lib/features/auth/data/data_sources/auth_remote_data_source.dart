import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_fridge/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(String email, String password, String displayName);
  Future<void> deleteUser();
  Future<void> logout();
  Future<void> resetPassword(String email);
  Future<void> updatePassword(String newPassword);
  Future<void> changeName(String newName);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot userDoc = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      return UserModel.fromFirestore(userDoc);
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<UserModel> signup(
      String email, String password, String displayName) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'displayName': displayName,
        'createdAt': FieldValue.serverTimestamp(),
      });
      DocumentSnapshot userDoc = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      return UserModel.fromFirestore(userDoc);
    } catch (e) {
      throw Exception('Failed to signup');
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      User user = firebaseAuth.currentUser!;
      await firestore.collection('users').doc(user.uid).delete();
      await user.delete();
    } catch (e) {
      throw Exception('Failed to delete user');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Failed to logout');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Failed to reset password');
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      User user = firebaseAuth.currentUser!;
      await user.updatePassword(newPassword);
    } catch (e) {
      throw Exception('Failed to update password');
    }
  }

  @override
  Future<void> changeName(String newName) async {
    try {
      User user = firebaseAuth.currentUser!;
      await firestore
          .collection('users')
          .doc(user.uid)
          .update({'displayName': newName});
    } catch (e) {
      throw Exception('Failed to change name');
    }
  }
}
