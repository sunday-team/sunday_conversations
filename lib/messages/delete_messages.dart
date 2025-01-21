import 'package:shared_preferences_listener/shared_preferences_listener.dart';
import 'package:sunday_core/Print/print.dart';

/// Deletes a specific message from a conversation.
///
/// This function removes a message identified by [messageId] from the conversation
/// specified by [conversationUUID]. It uses local storage to manage the messages.
///
/// Parameters:
/// - [conversationUUID]: The unique identifier of the conversation.
/// - [messageId]: The unique identifier of the message to be deleted.
///
/// Throws an [Exception] if the message is not found or if there's an error during deletion.
Future<void> asyncDeleteMessage({
  required String conversationUUID,
  required String messageId,
}) async {
  try {
    final prefs = SharedPreferencesListener();

    final dynamic rawMessages =
        prefs.read('sunday-message-conversation-$conversationUUID');
    if (rawMessages == null) {
      throw Exception('Conversation not found');
    }

    List<Map<String, dynamic>> messages =
        List<Map<String, dynamic>>.from(rawMessages as List);

    final indexToDelete = messages.indexWhere(
      (Map<String, dynamic> message) => message['messageId'] == messageId,
    );

    if (indexToDelete == -1) {
      throw Exception('Message not found');
    }

    messages.removeAt(indexToDelete);
    await prefs.write(
        'sunday-message-conversation-$conversationUUID', messages);

    sundayPrint(
        'Message with ID \'$messageId\' deleted from conversation: $conversationUUID');
  } catch (e) {
    sundayPrint('Error deleting message: $e');
    throw Exception('Error deleting message');
  }
}
