import 'package:uuid/uuid.dart';

Map<String, dynamic> messageSchema({
  required String content,
  required String autoMessageId,
  required bool isSender,
  required List<Map<String, dynamic>> reaction,
  required bool distributed,
  required bool seen,
  List<Map<String, String>>? attachments, // List of attachments
}) {
  return {
    "content": {
      "autoMessageId": autoMessageId,
      "content": content,
    },
    'messageId': const Uuid().v4(),
    'isSender': isSender,
    'timestamp': DateTime.now().toString(),
    'reaction': reaction,
    "distributed": distributed,
    "seen": seen,
    "attachments": attachments ?? [], // Add attachments to the message
  };
}

// for conversation start, use "automessageid:conversation-start".