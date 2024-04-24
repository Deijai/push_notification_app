import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_notification_app/domain/entities/push_message.dart';
import 'package:push_notification_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  await Firebase.initializeApp();
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final Future<void> Function()? requestLocalNotificationPermissions;
  final void Function(
      {required int id,
      String? title,
      String? body,
      String? data})? showLocalNotification;

  NotificationsBloc(
      {required this.requestLocalNotificationPermissions,
      required this.showLocalNotification})
      : super(const NotificationsState()) {
    on<NotificationStatusChange>(_notificationStatusChange);
    on<NotificationReceived>(_onPushMessageReceived);

    _initialStatusCheck();
    _onForegroundMessage();
  }

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificationStatusChange(
      NotificationStatusChange event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(authorizationStatus: event.authorizationStatus));

    _getFCMToken();
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChange(settings.authorizationStatus));
  }

  void _getFCMToken() async {
    if (state.authorizationStatus != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();

    print('Token: ${token}');
  }

  void handleRemoteMessage(RemoteMessage remoteMessage) {
    if (remoteMessage.notification == null) return;

    final notification = PushMessage(
      messageId:
          remoteMessage.messageId?.replaceAll(':', '').replaceAll('%', '') ??
              '',
      title: remoteMessage.notification!.title ?? '',
      body: remoteMessage.notification!.body ?? '',
      sendDate: remoteMessage.sentTime ?? DateTime.now(),
      data: remoteMessage.data,
      imageurl: Platform.isAndroid
          ? remoteMessage.notification!.android?.imageUrl
          : remoteMessage.notification!.apple?.imageUrl,
    );

    if (showLocalNotification != null) {
      showLocalNotification!(
        id: DateTime.now().millisecond,
        body: notification.body,
        data: notification.messageId,
        title: notification.title,
      );
    }

    add(NotificationReceived(message: notification));
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    if (requestLocalNotificationPermissions != null) {
      await requestLocalNotificationPermissions!();
    }

    add(NotificationStatusChange(settings.authorizationStatus));
  }

  void _onPushMessageReceived(
      NotificationReceived event, Emitter<NotificationsState> emit) async {
    emit(
        state.copyWith(notifications: [event.message, ...state.notifications]));
  }

  PushMessage? getMessageById(String pushMessageId) {
    final exist = state.notifications
        .any((element) => element.messageId == pushMessageId);

    if (!exist) return null;

    return state.notifications
        .firstWhere((element) => element.messageId == pushMessageId);
  }
}
