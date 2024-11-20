import 'package:uuid/uuid.dart';

/// Creates a message schema for group conversations.
///
/// This function generates a standardized structure for messages in group chats,
/// including content, sender information, reactions, and user-specific data.
///
/// Parameters:
/// - [content]: The main text content of the message.
/// - [isSender]: A boolean indicating if the current user is the sender (currently unused).
/// - [reaction]: A list of reaction data for the message (currently unused).
/// - [autoMessageId]: A unique identifier for automatic messages.
/// - [users]: A list of users involved in the conversation.
/// - [attachments]: An optional list of attachments for the message.
///
/// Returns a [Map<String, dynamic>] representing the message schema.
Map<String, dynamic> messageSchemaGroup({
  required String content,
  required bool isSender,
  required List<Map<String, dynamic>> reaction,
  required String autoMessageId,
  required List<Map<String, dynamic>> users,
  List<Map<String, String>>? attachments,
}) {
  return {
    'content': {
      'autoMessageId': autoMessageId,
      'content': content,
    },
    'messageId': const Uuid().v4(),
    'isSender': false,
    'timestamp': DateTime.now().toString(),
    'reaction': users
        .map((user) => {
              'userId': user['userId'],
              'seen': false,
              'distributed': true,
            })
        .toList(),
    'info': users
        .map((user) => {
              'userId': user['userId'],
              'seen': false,
              'distributed': true,
            })
        .toList(),
    'attachments': attachments ?? [],
  };
}

/// Note: For conversation start, use 'automessageid:conversation-start'.
