import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notification_app/config/router/app_router.dart';

class LocalNotification {
  static Future<void> requestPermissionLocalNotification() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> initializedNotifications() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  static void showLocalNotification(
      {required int id, String? title, String? body, String? data}) {
    const androidDetails = AndroidNotificationDetails(
        'channelId', 'channelName',
        playSound: true,
        sound: RawResourceAndroidNotificationSound('audio'),
        priority: Priority.high,
        importance: Importance.max);

    const notificationDetails = NotificationDetails(android: androidDetails);
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails,
        payload: data);
  }

  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    appRouter.push('/details/${response.payload}');
  }
}
