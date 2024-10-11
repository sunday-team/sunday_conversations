import 'package:uuid/uuid.dart';

Map<String, dynamic> messageSchemaGroup({
  required String content,
  required bool isSender,
  required List<Map<String, dynamic>> reaction,
  required String autoMessageId,
  required List<Map<String, dynamic>> users,
  List<Map<String, String>>? attachments, // New parameter for attachments
}) {
  return {
    "content": {
      "autoMessageId": autoMessageId,
      "content": content,
    },
    'messageId': const Uuid().v4(),
    'isSender': false,
    'timestamp': DateTime.now().toString(), // Ensure DateTime is a String
    'reaction': users
        .map((user) => {
              "userId": user["userId"],
              "seen": false, // Default value for seen
              "distributed": true, // Default value for distributed
            })
        .toList(),
    "info": users
        .map((user) => {
              "userId": user["userId"],
              "seen": false, // Default value for seen
              "distributed": true, // Default value for distributed
            })
        .toList(),
    "attachments": attachments ?? [], // Add attachments to the message
  };
}

// for conversation start, use "automessageid:conversation-start".