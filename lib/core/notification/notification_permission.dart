import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:smart_fridge/core/helper/shared_preferences_helper.dart';

Future<bool> requestNotificationPermission() async {
  // Check if notifications are already allowed
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();

  if (!isAllowed) {
    // Request permission from the user
    isAllowed =
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }
  SharedPreferencesHelper().saveBool('notificationPermission', isAllowed);

  return isAllowed; // Return whether notifications are now allowed
}

Future<void> disableNotifications() async {
  // Cancel all active and pending notifications
  await AwesomeNotifications().cancelAll();
  SharedPreferencesHelper().saveBool('notificationPermission', false);
}

Future<bool> toggleNotifications(bool allow) async {
  if (allow) {
    bool isAllowed = await requestNotificationPermission();
    if (isAllowed) {
      // Notifications are now allowed
      print('Notifications allowed');
      return true;
    } else {
      // User denied notification permission
      print('Notifications not allowed');
    }
  } else {
    await disableNotifications();
    print('Notifications disabled');
  }
  return false;
}
