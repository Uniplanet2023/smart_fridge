import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/bloc/read_receipt_bloc.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/pages/item_list_screen.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  File? image;

  Future<void> selectImage() async {
    final permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted ||
        permissionStatus.isLimited ||
        Platform.isAndroid) {
      pickImage();
    } else if (permissionStatus.isPermanentlyDenied) {
      Permission.photos.request();
      openAppSettings();
    } else {
      Permission.photos.request();
      if (context.mounted) {
        showDialog(
          // ignore: use_build_context_synchronously
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
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    // Check if an image was picked
    if (pickedFile != null) {
      // Update the state to reflect the picked image
      setState(() {
        image = File(pickedFile.path);
      });

      // Show confirmation dialog
      bool confirmUpload = await showUploadConfirmationDialog();
      if (confirmUpload) {
        // Assuming 'image' is a global variable that holds the File
        // Here you could upload the image to your server and then update the user's profile image URL
        serviceLocator<ReadReceiptBloc>().add(ScanReceiptEvent(image!));
      } else {
        // Reset the image to null if the user cancels the upload
        setState(() {
          image = null;
        });
      }
    } else {
      // Handle the case where no image is picked
      print("No image selected");
    }
  }

  Future<bool> showUploadConfirmationDialog() async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Upload Image'),
              content: const Text(
                  'Are you sure you want to upload this image as your profile picture?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Upload'),
                ),
              ],
            );
          },
        ) ??
        false; // Return false if the dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReadReceiptBloc, ReadReceiptState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ReadReceiptCompleted) {
          // navigate to the item list screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ItemListScreen(items: state.receiptData),
            ),
          );
        }
      },
      child: Scaffold(
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
                image != null ? Image.file(image!) : const SizedBox(),
                FloatingActionButton(
                  heroTag: 'pickImageFromGallery', // Add a unique heroTag
                  onPressed: () {
                    pickImage();
                  },
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo),
                ),
                SizedBox(height: 10.h),
                const Text('Add receipt image from gallery'),
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
                  heroTag: 'takePicture', // Add a unique heroTag
                  onPressed: () {},
                  tooltip: 'Take a picture',
                  child: const Icon(Icons.camera_alt_outlined),
                ),
                SizedBox(height: 10.h),
                const Text('Take a picture of receipt'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
