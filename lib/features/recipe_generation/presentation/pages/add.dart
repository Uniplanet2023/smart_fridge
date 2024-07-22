import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  XFile? _selectedImage;

  // Future _pickImageFromGallery() async {
  //   print('object');
  //   // final returnedImage =
  //   //     await ImagePicker().pickImage(source: ImageSource.gallery);

  //   // if (returnedImage == null) return;

  //   // setState(() {
  //   //   _selectedImage = File(returnedImage.path);
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Scan receipt',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                    Text(
                      '|',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Share Video',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              _selectedImage != null
                  ? Image.file(_selectedImage! as File)
                  : const SizedBox(),
              FloatingActionButton(
                onPressed: () {
                  _pickImageFromGallery(context);
                },
                tooltip: 'Pick Image from gallery',
                child: const Icon(Icons.photo),
              ),
              SizedBox(height: 10.h),
              Text('Add receipt image from gallery'),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    const Expanded(child: Divider()),
                    Text(
                      "   or    ",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant, // Change this to your desired color
                          fontWeight: FontWeight.w600),
                    ),
                    const Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
              ),
              FloatingActionButton(
                onPressed: () {},
                tooltip: 'Take a picture',
                child: const Icon(Icons.camera_alt_outlined),
              ),
              SizedBox(height: 10.h),
              Text('Take a picture of receipt'),
            ],
          ),
        ),
      ),
    );
  }
}

Future<XFile?> _pickImageFromGallery(BuildContext context) async {
  XFile? pickedImage;

  // Check gallery permission status
  var permissionStatus = await Permission.photos.status;

  if (permissionStatus.isGranted || Platform.isAndroid) {
    try {
      pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (e) {
      print('Error picking image: $e');
    }
  } else if (permissionStatus.isDenied) {
    // If permission is denied, request it again
    var requested = await Permission.photos.request();
    if (requested.isGranted) {
      try {
        pickedImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      } catch (e) {
        print('Error picking image: $e');
      }
    } else {
      // If permission still denied, show a dialog or snackbar
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Permission needed"),
            content: const Text("This app needs gallery access to pick images"),
            actions: <Widget>[
              TextButton(
                child: const Text("Deny"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text("Settings"),
                onPressed: () => openAppSettings(), // Open app settings
              ),
            ],
          ),
        );
      }
    }
  } else if (permissionStatus.isLimited) {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  } else {
    // Direct the user to the settings if permissions are permanently denied
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Permission Denied"),
          content: const Text(
              "You have permanently denied access to photos. Please enable access in the system settings."),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Settings"),
              onPressed: () => openAppSettings(), // Open app settings
            ),
          ],
        ),
      );
    }
  }

  //   setState(() {
  //   _selectedImage = File(pickedImage!.path);
  // });

  return pickedImage;
}
