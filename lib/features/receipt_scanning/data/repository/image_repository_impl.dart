// data/repositories/image_repository_impl.dart

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smart_fridge/features/receipt_scanning/domain/repository/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final FirebaseStorage firebaseStorage;

  ImageRepositoryImpl({required this.firebaseStorage});

  @override
  Future<String> uploadImage(File image) async {
    try {
      final ref =
          firebaseStorage.ref().child('uploads/${image.path.split('/').last}');
      final uploadTask = await ref.putFile(image);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
