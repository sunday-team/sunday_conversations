import 'package:uuid/uuid.dart';

Map<String, dynamic> messageSchema({
  required String content,
  required String autoMessageId,
  required bool isSender,
  required List<Map<String, dynamic>> reaction,
  required bool distributed,
  required bool seen,
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
    "seen": seen
  };
}

// for conversation start, use "automessageid:conversation-start".