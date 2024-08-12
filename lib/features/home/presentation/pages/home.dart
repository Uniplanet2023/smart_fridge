import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/features/home/presentation/blocs/shared_recipe_bloc/shared_recipe_bloc.dart';
import 'package:smart_fridge/features/home/presentation/widgets/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> videoUrls = [];

  @override
  void initState() {
    serviceLocator<SharedRecipeBloc>().add(const FetchSharedRecipesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedRecipeBloc, SharedRecipeState>(
      builder: (context, state) {
        if (state is SharedRecipeLoaded) {
          videoUrls.clear();
          for (final recipe in state.recipes) {
            videoUrls.add(recipe.videoUrl);
          }
        }
        return Scaffold(
          backgroundColor: Colors.black,
          body: videoUrls.isNotEmpty
              ? PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: videoUrls.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        VideoPlayerWidget(videoUrl: videoUrls[index]),
                        const Positioned(
                          right: 10,
                          top: 100,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg'),
                              ),
                              SizedBox(height: 10),
                              Icon(Icons.favorite, color: Colors.red, size: 40),
                              SizedBox(height: 10),
                              Text('2', style: TextStyle(color: Colors.white)),
                              SizedBox(height: 10),
                              Icon(Icons.chat_bubble_outline,
                                  color: Colors.white, size: 40),
                              SizedBox(height: 10),
                              Text('0', style: TextStyle(color: Colors.white)),
                              SizedBox(height: 10),
                              Icon(Icons.reply, color: Colors.white, size: 40),
                              SizedBox(height: 10),
                              Text('0', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        const Positioned(
                          bottom: 10,
                          left: 10,
                          child: Text(
                            'rivaanranawat\nNo Song, Only Trip!',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    );
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
