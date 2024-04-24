part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class NotificationStatusChange extends NotificationsEvent {
  final AuthorizationStatus authorizationStatus;

  const NotificationStatusChange(this.authorizationStatus);
}

class NotificationReceived extends NotificationsEvent {
  final PushMessage message;

  const NotificationReceived({required this.message});
}
