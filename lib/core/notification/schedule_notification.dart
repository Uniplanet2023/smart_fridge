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
      date: DateTime.now()
          .add(const Duration(seconds: 10)), // Schedule for 10 seconds later
    ),
  );
}

void scheduleNotificationForItems(List<ItemModel> items) {
  for (final item in items) {
    scheduleNotificationForItem(item);
  }
}
