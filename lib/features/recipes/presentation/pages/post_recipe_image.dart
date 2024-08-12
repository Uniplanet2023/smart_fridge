import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_fridge/config/routes/names.dart';
import 'package:smart_fridge/core/domain_layer_entities/save_recipe.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/core/util/image_permissions.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/bloc/read_receipt_bloc.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/pages/new_items_page.dart';
import 'package:smart_fridge/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:video_player/video_player.dart';

class PostRecipeImagePage extends StatefulWidget {
  final SaveRecipe recipe;
  const PostRecipeImagePage({super.key, required this.recipe});

  @override
  State<PostRecipeImagePage> createState() => _PostRecipeImagePageState();
}

class _PostRecipeImagePageState extends State<PostRecipeImagePage> {
  File? video;
  VideoPlayerController? _videoPlayerController;
  final int maxVideoDurationInSeconds = 120; // 2 minutes = 120 seconds
  bool isVideoProcessing = false;

  Future<void> pickVideo() async {
    // Check gallery permission, if not allowed stop
    if (await ImagePermissions(context).isAllowed() == false) {
      return;
    }
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickVideo(source: ImageSource.gallery);

    // Check if a video was picked
    if (pickedFile != null) {
      // Initialize the VideoPlayerController with the selected video
      _videoPlayerController =
          VideoPlayerController.file(File(pickedFile.path));
      await _videoPlayerController!.initialize();

      // Get the video duration
      final videoDuration = _videoPlayerController!.value.duration;

      // Check if the video duration is within the allowed limit
      if (videoDuration.inSeconds <= maxVideoDurationInSeconds) {
        setState(() {
          video = File(pickedFile.path);
          _videoPlayerController!.play();
        });
      } else {
        // Show a warning message if the video exceeds the allowed duration
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            content: Text(
              'Video exceeds the 2-minute limit. Please select a shorter video.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
          ),
        );
        _videoPlayerController!.dispose();
        _videoPlayerController = null;
      }
    } else {
      // Handle the case where no video is picked
      print("No video selected");
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecipeBloc, RecipeState>(
      listener: (context, state) {
        if (state is RecipeUploading) {
          isVideoProcessing = true;
          setState(() {});
        } else if (state is RecipeUploadSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              content: Text(
                'Recipe uploaded successfully!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ),
          );
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.bottomBarPage,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Post Your Cooking',
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (isVideoProcessing) const CircularProgressIndicator(),
                      if (video != null && _videoPlayerController != null)
                        AspectRatio(
                          aspectRatio:
                              _videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController!),
                        )
                      else
                        Lottie.asset(
                          'assets/animations/cooking.json',
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
                              const Icon(Icons.video_collection_outlined),
                              'Add from Gallery',
                              pickVideo),
                        ],
                      ),
                    ],
                  ),
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
                                        .onSurfaceVariant,
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
        floatingActionButton: video != null
            ? FloatingActionButton.extended(
                onPressed: () {
                  // Implement your post functionality here
                  serviceLocator<RecipeBloc>().add(
                    UploadRecipeEvent(recipe: widget.recipe, videoFile: video),
                  );
                },
                label: const Text('Post'),
                icon: const Icon(Icons.upload),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
