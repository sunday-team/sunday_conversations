import 'package:shared_preferences_listener/shared_preferences_listener.dart';
import 'package:sunday_conversations/conversations/edit_conversation.dart';
import 'package:sunday_core/Print/print.dart';

/// Edits a specific message in a conversation.
///
/// This function allows for the modification of a single key-value pair
/// in a message within a specified conversation.
///
/// Parameters:
/// - [conversationUUID]: The unique identifier for the conversation.
/// - [messageId]: The unique identifier for the message to be edited.
/// - [key]: The key of the field to be edited in the message.
/// - [value]: The new value to be set for the specified key.
///
/// Throws an [Exception] if the message is not found or if there's an error during the editing process.
Future<void> asyncEditMessage({
  required String conversationUUID,
  required String messageId,
  required String key,
  required dynamic value,
}) async {
  try {
    final prefs = SharedPreferencesListener();

    var messages =
        prefs.read('sunday-message-conversation-$conversationUUID') ?? [];
    messages = (messages as List).toList();

    final indexToEdit = messages.indexWhere(
      (message) => message['messageId'] == messageId,
    );

    if (indexToEdit == -1) {
      throw Exception('Message not found');
    }

    messages[indexToEdit][key] = value;
    messages[indexToEdit]['updatedAt'] = DateTime.now().toString();

    await asyncEditConversation(
      conversationUUID: conversationUUID,
      property: 'updatedAt',
      newValue: DateTime.now().toString(),
    );

    await prefs.write(
        'sunday-message-conversation-$conversationUUID', messages);
    sundayPrint(
        'Message with ID \'$messageId\' edited in conversation: $conversationUUID');
  } catch (e) {
    sundayPrint('Error editing message: $e');
    throw Exception('Error editing message');
  }
}
