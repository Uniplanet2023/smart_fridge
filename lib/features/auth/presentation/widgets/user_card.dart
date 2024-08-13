import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/core/util/image_permissions.dart';
import 'package:smart_fridge/features/auth/domain/entities/user.dart';
import 'package:smart_fridge/features/auth/presentation/blocs/profile_bloc/profile_bloc.dart';

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
        // Upload the image to your server and then update the user's profile image URL
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
      log("No image selected");
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
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUploaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              content: Text(
                "Profile picture updated!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ),
          );
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              content: Text(
                "Error while updating profile picture!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ),
          );
        }
      },
      child: Container(
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
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileUploading) {
                  return const CircularProgressIndicator.adaptive();
                } else {
                  return Stack(
                    children: [
                      (widget.currentUser!.profilePicture != null)
                          ? CircleAvatar(
                              radius: 50.w,
                              backgroundImage: CachedNetworkImageProvider(
                                  widget.currentUser!.profilePicture!),
                            )
                          : (widget.currentUser != null)
                              ? CircleAvatar(
                                  radius: 50.w,
                                  child: Text(
                                    widget.currentUser!.name[0].toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 50.w,
                                  child: Image(
                                    height: 50.w,
                                    fit: BoxFit.contain,
                                    image: const AssetImage(
                                        'assets/images/user_default_pfp.png'),
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
                  );
                }
              },
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
      ),
    );
  }
}
