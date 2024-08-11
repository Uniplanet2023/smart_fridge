import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_fridge/config/routes/router.dart';
import 'package:smart_fridge/config/theme/cubit/theme_cubit.dart';
import 'package:smart_fridge/config/widgets/bottom_bar.dart';
import 'package:smart_fridge/core/resources/initialization.dart';
import 'package:smart_fridge/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:smart_fridge/features/auth/presentation/pages/signin_page.dart';
import 'package:smart_fridge/features/fridge_management/presentation/bloc/fridge_management_bloc.dart';
import 'package:smart_fridge/features/auth/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/bloc/item_list/item_list_bloc.dart';
import 'package:smart_fridge/features/receipt_scanning/presentation/bloc/read_receipt_bloc.dart';
import 'package:smart_fridge/features/recipe_generation/presentation/bloc/bloc/recipe_generation_bloc.dart';
import 'package:smart_fridge/features/recipes/presentation/bloc/recipe_bloc.dart';

void main() async {
  // Initialize Firebase and set system UI overlay style
  await Initialization.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
      BlocProvider(create: (_) => serviceLocator<ReadReceiptBloc>()),
      BlocProvider(create: (_) => serviceLocator<ItemListBloc>()),
      BlocProvider(create: (_) => serviceLocator<FridgeManagementBloc>()),
      BlocProvider(create: (_) => serviceLocator<RecipeGenerationBloc>()),
      BlocProvider(create: (_) => serviceLocator<ProfileBloc>()),
      BlocProvider(create: (_) => serviceLocator<RecipeBloc>()),
      BlocProvider(create: (context) => ThemeCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  // GlobalKey for the navigator
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    context.read<AuthBloc>().add(CheckUserTokenEvent());
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: MyApp.navigatorKey,
            title: 'Smart Fridge',
            onGenerateRoute: (settings) => generateRoute(settings),
            theme: state,
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoaded) {
                  return const BottomBar();
                }
                return const SigninPage();
              },
            ),
          );
        },
      ),
    );
  }
}
