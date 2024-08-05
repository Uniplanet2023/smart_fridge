import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// A class to manage image selection permissions
class ImagePermissions {
  final BuildContext context;
  ImagePermissions(this.context);

  // A method to check and request image selection permissions
  Future<bool> isAllowed() async {
    final permissionStatus = await Permission
        .photos.status; // Check the current status of the photo permissions
    if (permissionStatus.isGranted ||
        permissionStatus.isLimited ||
        Platform.isAndroid) {
      // If permission is granted or limited, or if the platform is Android, return true
      return true;
    } else if (permissionStatus.isPermanentlyDenied) {
      // If permission is permanently denied, request permission and open app settings
      Permission.photos.request();
      openAppSettings();
      return false;
    } else {
      // For other permission statuses, request permission
      Permission.photos.request();
      if (context.mounted) {
        // Check if the context is still mounted (i.e., if the widget is still part of the widget tree)
        showDialog(
          // ignore: use_build_context_synchronously
          context:
              context, // Show a dialog to inform the user that permission is needed
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Permission needed"), // Dialog title
            content: const Text(
                "This app needs gallery access to pick images"), // Dialog content
            actions: <Widget>[
              TextButton(
                child: const Text("Deny"), // Button to deny permission
                onPressed: () =>
                    Navigator.of(context).pop(), // Close the dialog
              ),
              TextButton(
                child: const Text("Settings"), // Button to open app settings
                onPressed: () =>
                    openAppSettings(), // Open app settings to allow the user to change permissions
              ),
            ],
          ),
        );
      }
      return false; // Return false if permission is not granted
    }
  }
}
