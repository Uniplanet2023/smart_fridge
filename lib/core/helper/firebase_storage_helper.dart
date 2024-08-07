import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfileImage(File image, String userId) async {
    try {
      final ref = _storage.ref().child('profile_images').child('$userId.jpg');
      await ref.putFile(image);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Error uploading profile image: $e');
    }
  }
}
