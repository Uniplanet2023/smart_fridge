// domain/repositories/image_repository.dart

import 'dart:io';

abstract class ImageRepository {
  Future<String> uploadImage(File image);
}
