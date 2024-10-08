import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_fridge/core/helper/gemini_helper.dart';
import 'package:smart_fridge/core/helper/isar_helper.dart';
import 'package:smart_fridge/core/helper/shared_preferences_helper.dart';
import 'package:smart_fridge/core/notification/notification_permission.dart';
import 'package:smart_fridge/core/resources/auth_injection.dart';
import 'package:smart_fridge/core/resources/firebase_options.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_fridge/core/resources/fridge_management_injection.dart';
import 'package:smart_fridge/core/resources/read_recipe_injection.dart';
import 'package:smart_fridge/core/resources/recipe_generation_injection.dart';
import 'package:smart_fridge/core/resources/injection_profile.dart';
import 'package:smart_fridge/core/resources/scanned_items_save_dependency.dart';
import 'package:smart_fridge/core/resources/recipe_injection.dart';
import 'package:smart_fridge/core/resources/shared_recipe_injection.dart';

final serviceLocator = GetIt.instance;

class Initialization {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    // Initialize Gemini
    if (dotenv.env['GEMINI_API_KEY'] == null) {
      throw Exception('Gemini API Key is missing');
    } else {
      GeminiHelper.instance.initialize(dotenv.env['GEMINI_API_KEY']!);
    }
    await IsarHelper.instance.openIsar();

    // Initialize Firebase
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    // Call Auth feature initialization
    await AuthInjection.init(serviceLocator);

    // notification setting
    AwesomeNotifications().initialize(
      null, // Your app icon resource path
      [
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Notifications',
          channelDescription:
              'Notification channel for scheduled notifications',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
        )
      ],
    );
    await requestNotificationPermission();

    initReadReceipt(serviceLocator); // Read receipt feature initialization
    initItemList(serviceLocator); // scanned items saving feature initialization
    initGeneratingRecipe(); // Generate Recipe initialization
    initProfile(serviceLocator); // Profile initialization in Auth
    setupRecipe(serviceLocator); // Recipe feature initializations
    setupSharedRecipe(serviceLocator); // Shared Recipe feature initialization
    setupItem(serviceLocator); // Fridge Management feature initialization

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
