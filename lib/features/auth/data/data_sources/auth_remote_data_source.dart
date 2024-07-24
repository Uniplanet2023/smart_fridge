import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_fridge/core/helper/shared_preferences_helper.dart';
import 'package:smart_fridge/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(String email, String password, String displayName);
  Future<void> deleteUser();
  Future<void> logout();
  Future<void> resetPassword(String email);
  Future<void> updatePassword(
      String email, String password, String newPassword);
  Future<void> changeName(String newName);
  Future<UserModel> signInWithGoogle();
  Future<UserModel?> checkUserTokenExists();
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

      // Get user information from Firestore
      if (userCredential.user != null) {
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        // Ensure the user document exists
        if (userDoc.exists) {
          // Save user information in device using shared preferences
          // First Convert UserModel to JSON string
          String savedUser = UserModel.fromFirestore(userDoc).toJson();
          // Save user information string to shared preferences
          await SharedPreferencesHelper().saveString('userData', savedUser);

          return UserModel.fromFirestore(userDoc);
        } else {
          throw Exception('User does not exist');
        }
      } else {
        throw Exception('User credential is null');
      }
      // return UserModel.fromFirestore(userDoc);
    } on FirebaseAuthException catch (e) {
      // Handle Firebase specific errors
      throw Exception('FirebaseAuthException: ${e.message}');
    } on FirebaseException catch (e) {
      // Handle Firestore specific errors
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Failed to login: ${e.toString()}');
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

      // Save user information in device using shared preferences
      // First Convert UserModel to JSON string
      String savedUser = UserModel.fromFirestore(userDoc).toJson();
      // Save user information string to shared preferences
      await SharedPreferencesHelper().saveString('userData', savedUser);

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
      // remove user information string from shared preferences
      await SharedPreferencesHelper().remove('userData');
    } catch (e) {
      throw Exception('Failed to delete user');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      // remove user information string from shared preferences
      await SharedPreferencesHelper().remove('userData');
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
  Future<void> updatePassword(
      String email, String password, String newPassword) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) {
        throw Exception('User credential is null');
      }
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

  @override
  Future<UserModel> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw Exception('Failed to sign in with Google');
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user;

    if (user == null) {
      throw Exception('Failed to retrieve user from Firebase');
    }
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(userCredential.user!.uid).get();

    // Ensure the user document exists
    if (userDoc.exists) {
      return UserModel.fromFirestore(userDoc);
    } else {
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': user.email!,
        'displayName': user.displayName!,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return UserModel(
        userId: user.uid,
        name: user.displayName!,
        email: user.email!,
      );
    }
  }

  @override
  Future<UserModel?> checkUserTokenExists() async {
    try {
      // Get the user data from shared preferences
      String? userData = SharedPreferencesHelper().getString('userData');
      if (userData != null) {
        // Convert JSON string to UserModel
        return UserModel.fromJson(userData);
      }
    } catch (e) {
      // Handle any exceptions
      throw Exception('Error checking user token: $e');
    }
    return null;
  }
}
