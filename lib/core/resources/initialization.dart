// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Initialization {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(options: DefaultFirebaseOptions.cu);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);

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
