import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_notification_app/domain/entities/push_message.dart';
import 'package:push_notification_app/presentation/blocs/notifications/notifications_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final String pushMessageId;
  const DetailsScreen({super.key, required this.pushMessageId});

  @override
  Widget build(BuildContext context) {
    final PushMessage? pushMessage =
        context.watch<NotificationsBloc>().getMessageById(pushMessageId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page: Message Push'),
      ),
      body: (pushMessage != null)
          ? _DetailsView(pushMessage: pushMessage)
          : const Center(
              child: Text('Não há dados'),
            ),
    );
  }
}

class _DetailsView extends StatelessWidget {
  final PushMessage pushMessage;
  const _DetailsView({required this.pushMessage});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(children: [
        if (pushMessage.imageurl != null) Image.network(pushMessage.imageurl!),
        const SizedBox(
          height: 30,
        ),
        Text(pushMessage.title, style: textStyles.titleMedium),
        Text(pushMessage.body, style: textStyles.titleMedium),
        const Divider(),
        Text(pushMessage.data.toString()),
      ]),
    );
  }
}
