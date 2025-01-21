import 'package:shared_preferences_listener/shared_preferences_listener.dart';
import 'package:sunday_conversations/conversations/edit_conversation.dart';
import 'package:sunday_conversations/schemas/message_shema.dart';
import 'package:sunday_core/Print/print.dart';

/// Adds a new message to a conversation.
///
/// This function creates a new message using the provided parameters and adds it
/// to the specified conversation in storage.
///
/// Parameters:
/// - [conversationUUID]: The unique identifier for the conversation.
/// - [content]: The text content of the message.
/// - [isSender]: A boolean indicating whether the current user is the sender.
/// - [reaction]: A list of reactions associated with the message.
/// - [attachments]: An optional list of attachments for the message.
///
/// Throws an [Exception] if there's an error adding the new message.
Future<void> asyncAddNewMessage({
  required String conversationUUID,
  required String content,
  required bool isSender,
  required List<Map<String, dynamic>> reaction,
  List<Map<String, String>>? attachments,
}) async {
  try {
    final prefs = SharedPreferencesListener();

    var newMessage = messageSchema(
      content: content,
      autoMessageId: 'automessageid:new-message',
      isSender: isSender,
      reaction: reaction,
      distributed: true,
      seen: false,
      attachments: attachments,
    );

    var messages =
        prefs.read('sunday-message-conversation-$conversationUUID') ?? [];
    var newMessages = messages;
    newMessages.add(newMessage);

    await prefs.write(
        'sunday-message-conversation-$conversationUUID', newMessages);
    
    // Update the 'updatedAt' timestamp for the conversation
    await asyncEditConversation(
      conversationUUID: conversationUUID,
      property: 'updatedAt',
      newValue: DateTime.now().toString(),
    );

    sundayPrint('New message added to conversation: $conversationUUID');
  } catch (e) {
    sundayPrint('Error adding new message: $e');
    throw Exception('Error adding new message');
  }
}
