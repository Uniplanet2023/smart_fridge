// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_fridge/core/helper/dio_helper.dart';
import 'package:smart_fridge/core/helper/shared_preferences_helper.dart';
import 'package:smart_fridge/core/resources/auth_injection.dart';
import 'package:smart_fridge/core/resources/firebase_options.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

class Initialization {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    // Call Auth feature initialization
    await AuthInjection.init(serviceLocator);

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Initialize Dio
    await DioHelper.initialize();

    // Initialize SharedPreferences
    await SharedPreferencesHelper().init();

    ErrorWidget.builder = (FlutterErrorDetails details) {
      bool inDebug = false;
      assert(() {
        inDebug = true;
        return true;
      }());
      if (inDebug) {
        return ErrorWidget(details.exception);
      }
      return const Scaffold(
        body: Center(
          child: Text('An error occurred!'),
        ),
      );
    };
  }
}
