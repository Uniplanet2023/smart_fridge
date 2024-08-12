import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/features/auth/domain/entities/user.dart';
import 'package:smart_fridge/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:smart_fridge/features/home/data/models/shared_recipe.dart';
import 'package:smart_fridge/features/home/presentation/blocs/shared_recipe_bloc/shared_recipe_bloc.dart';
import 'package:smart_fridge/features/home/presentation/widgets/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<SharedRecipe> recipes = [];
  final User user = serviceLocator<AuthBloc>().state.user;

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
          recipes.clear();

          for (final recipe in state.recipes) {
            recipes.add(recipe);
          }
        }
        return Scaffold(
          backgroundColor: Colors.black,
          body: recipes.isNotEmpty
              ? PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        VideoPlayerWidget(videoUrl: recipes[index].videoUrl),
                        Positioned(
                          right: 10,
                          top: 100,
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg'),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  serviceLocator<SharedRecipeBloc>().add(
                                    LikeSharedRecipeEvent(
                                      recipes[index].recipeId,
                                      user.userId,
                                    ),
                                  );
                                  recipes[index].likes.contains(user.userId)
                                      ? recipes[index].likes.remove(user.userId)
                                      : recipes[index].likes.add(user.userId);
                                  setState(() {});
                                },
                                child:
                                    recipes[index].likes.contains(user.userId)
                                        ? const Icon(Icons.favorite,
                                            color: Colors.red, size: 40)
                                        : const Icon(Icons.favorite_border,
                                            color: Colors.white, size: 40),
                              ),
                              const SizedBox(height: 10),
                              Text(recipes[index].likes.length.toString(),
                                  style: const TextStyle(color: Colors.white)),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () async {
                                  await Share.share(
                                      'Check out this awesome recipe: ${recipes[index].name}!\n\nIngredients: ${recipes[index].ingredients.join(', ')}\nInstructions: ${recipes[index].instructions.join('\n')}\n\nShared via Smart Fridge App');
                                },
                                child: const Icon(Icons.reply,
                                    color: Colors.white, size: 40),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Text(
                            recipes[index].name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
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
