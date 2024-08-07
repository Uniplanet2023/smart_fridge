import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/core/util/image_permissions.dart';
import 'package:smart_fridge/features/auth/domain/entities/user.dart';
import 'package:smart_fridge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smart_fridge/features/profile/presentation/bloc/profile_bloc.dart';

class UserCard extends StatefulWidget {
  final User? currentUser;
  const UserCard({super.key, required this.currentUser});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  File? image;

  Future<void> pickImage() async {
    // Check gallery permission, if not allowed stop
    if (await ImagePermissions(context).isAllowed() == false) {
      return;
    }
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
        // serviceLocator<AuthBloc>().add(ChangeProfilePictureEvent(image!));
        serviceLocator<ProfileBloc>()
            .add(UploadProfileImage(image!, widget.currentUser!.userId));
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
              title: const Text(
                'Upload new Profile picture',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              scrollable: true,
              content: Column(
                children: [
                  Image.file(
                    image!,
                    fit: BoxFit.fill,
                    height: 300.h,
                  ),
                  Text(
                    'Continue with selection?',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Continue'),
                ),
              ],
            );
          },
        ) ??
        false; // Return false if the dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 12),
          )
        ],
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Stack(
            children: [
              CircleAvatar(
                radius: 50.w,
                backgroundImage: const CachedNetworkImageProvider(
                  'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=826&t=st=1721237500~exp=1721238100~hmac=43d94e13fa49ce48c9d21d0156c3beeddb78238322d055c7b270d37fc2217f99',
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: InkWell(
                  onTap: pickImage,
                  child: Icon(
                    Icons.camera_alt,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            widget.currentUser!.name,
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
          ),
          Text(
            widget.currentUser!.email,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}
