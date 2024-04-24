class PushMessage {
  final String messageId;
  final String title;
  final String body;
  final DateTime sendDate;
  final Map<String, dynamic>? data;
  final String? imageurl;

  PushMessage(
      {required this.messageId,
      required this.title,
      required this.body,
      required this.sendDate,
      this.data,
      this.imageurl});

  @override
  String toString() {
    return '''
    PushMessage =>
    MessageId: $messageId,
    Title: $title,
    Body: $body,
    SendDate: $sendDate,
    Data: $data,
    Image: $imageurl
          ''';
  }
}
