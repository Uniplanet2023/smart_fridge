import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:smart_fridge/core/data_layer_models/item_model.dart';

void scheduleNotificationForItem(ItemModel item) {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: item.id.hashCode,
      channelKey: 'scheduled_channel',
      title: '${item.name} is expiring soon!',
      body: '${item.name} is expiring on tomorrow!',
    ),
    schedule: NotificationCalendar.fromDate(
      date: item.expiryDate.subtract(
          const Duration(days: 1)), // Schedule for 1 day before expiry
    ),
  );
}

void scheduleNotificationForItems(List<ItemModel> items) {
  for (final item in items) {
    scheduleNotificationForItem(item);
  }
}
