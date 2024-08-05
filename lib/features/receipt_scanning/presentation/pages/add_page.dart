import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/core/util/image_permissions.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/bloc/read_receipt_bloc.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/pages/new_items_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
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
        // Here you could upload the image and then fetch the items in the receipt
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
              title: const Text(
                'Upload Receipt',
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
    return BlocListener<ReadReceiptBloc, ReadReceiptState>(
      listener: (context, state) {
        if (state is ReadReceiptCompleted) {
          // navigate to the item list screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ItemListPage(items: state.receiptData),
            ),
          );
        } else if (state is ReadReceiptError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              content: Text(
                state.message,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
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
                    SizedBox(height: 10.h),
                    Lottie.asset(
                      'assets/animations/scan receipt.json',
                      height: 400.h,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildAddReceiptOptions(
                            const Icon(Icons.camera_alt_outlined),
                            'Take Photo',
                            () {}),
                        _buildAddReceiptOptions(
                            const Icon(Icons.image_outlined),
                            'Add from Gallery',
                            pickImage),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<ReadReceiptBloc, ReadReceiptState>(
              builder: (context, state) {
                if (state is ReadingReceipt) {
                  return Container(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceDim
                        .withOpacity(0.5),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(height: 10.h),
                          Text(
                            'Processing ...',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant, // Change this to your desired color
                                    fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildAddReceiptOptions(Icon icon, String text, Function()? ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 150.w,
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: Theme.of(context).colorScheme.inverseSurface),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              height: 5.h,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

// Text.rich(
//   TextSpan(
//     text: '1. ',
//     style: Theme.of(context).textTheme.headlineLarge,
//     children: [
//       TextSpan(
//         text: 'Upload or capture a receipt image',
//         style: Theme.of(context).textTheme.headlineMedium,
//       ),
//     ],
//   ),
// ),
// SizedBox(height: 20.h),
// Text.rich(
//   TextSpan(
//     text: '2. ',
//     style: Theme.of(context).textTheme.headlineLarge,
//     children: [
//       TextSpan(
//         text:
//             'Review scanned items: add missing \nitems, correct details, and remove errors.',
//         style: Theme.of(context).textTheme.headlineMedium,
//       ),
//     ],
//   ),
// ),
// SizedBox(height: 20.h),
// Text.rich(
//   TextSpan(
//     text: '3. ',
//     style: Theme.of(context).textTheme.headlineLarge,
//     children: [
//       TextSpan(
//         text: 'Select items to add to fridge inventory.',
//         style: Theme.of(context).textTheme.headlineMedium,
//       ),
//     ],
//   ),
// ),
// SizedBox(height: 20.h),
// Text.rich(
//   TextSpan(
//     text: '4. ',
//     style: Theme.of(context).textTheme.headlineLarge,
//     children: [
//       TextSpan(
//         text:
//             'Save and verify items in fridge \n    inventory page.',
//         style: Theme.of(context).textTheme.headlineMedium,
//       ),
//     ],
//   ),
// ),
