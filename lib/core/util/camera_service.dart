import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService {
  final ImagePicker _imagePicker = ImagePicker();

  // Method to open the camera and handle permissions
  Future<File?> openCamera(BuildContext context) async {
    if (Platform.isAndroid) {
      // Request camera permission for Android
      await Permission.camera.request();
    }

    // Check camera permission status
    var permissionStatus = await Permission.camera.status;

    if (permissionStatus.isGranted) {
      return await _captureImage();
    } else if (permissionStatus.isDenied) {
      // If permission is denied, request it again
      var requested = await Permission.camera.request();
      if (requested.isGranted) {
        if (context.mounted) {
          return openCamera(context); // Recursive call to open the camera again
        }
      } else {
        // Permission still denied, handle appropriately
        _showPermissionDeniedMessage();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      // Direct the user to the settings if permissions are permanently denied
      if (context.mounted) {
        _showSettingsDialog(context);
      }
    }
    return null;
  }

  // Private method to capture image using the camera
  Future<File?> _captureImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // Private method to show a message when permission is denied
  void _showPermissionDeniedMessage() {
    log('Camera permission is denied.');
  }

  // Private method to show a dialog directing the user to settings
  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Permission Denied"),
        content: const Text(
            "You have permanently denied access to the camera. Please enable access in the system settings."),
        actions: <Widget>[
          TextButton(
            child: const Text("Close"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text("Settings"),
            onPressed: () {
              openAppSettings(); // Open app settings
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
