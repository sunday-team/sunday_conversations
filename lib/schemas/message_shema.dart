import 'package:uuid/uuid.dart';

/// Represents the schema for a message in the conversation.
///
/// This function creates a standardized structure for messages,
/// including content, metadata, and optional attachments.
///
/// [content] The main text content of the message.
/// [autoMessageId] A unique identifier for automatic messages.
/// [isSender] Indicates whether the current user is the sender of this message.
/// [reaction] A list of reactions to this message.
/// [distributed] Indicates whether the message has been distributed.
/// [seen] Indicates whether the message has been seen by the recipient.
/// [attachments] Optional list of attachments associated with the message.
///
/// Returns a [Map<String, dynamic>] representing the message structure.
Map<String, dynamic> messageSchema({
  required String content,
  required String autoMessageId,
  required bool isSender,
  required List<Map<String, dynamic>> reaction,
  required bool distributed,
  required bool seen,
  List<Map<String, String>>? attachments,
}) {
  // Get current timestamp and convert to ISO string immediately to avoid DateTime serialization issues
  // final String timestamp = DateTime.now().toIso8601String();
  
  return {
    'content': {
      'autoMessageId': autoMessageId,
      'content': content,
    },
    'messageId': const Uuid().v4(),
    'isSender': isSender,
    // 'timestamp': timestamp,
    'reaction': reaction,
    'distributed': distributed,
    'seen': seen,
    'attachments': attachments ?? [],
  };
}

/// Note: For conversation start, use 'automessageid:conversation-start'.
