import 'package:sunday_get_storage/sunday_get_storage.dart';
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
Future<void> AddNewMessage({
  required String conversationUUID,
  required String content,
  required bool isSender,
  required List<Map<String, dynamic>> reaction,
  List<Map<String, String>>? attachments,
}) async {
  try {
    /// Initialize GetStorage for data persistence
    final box = GetStorage();

    /// Create a new message using the message schema
    var newMessage = messageSchema(
      content: content,
      autoMessageId: "automessageid:new-message",
      isSender: isSender,
      reaction: reaction,
      distributed: true,
      seen: false,
      attachments: attachments,
    );

    /// Retrieve existing messages for the conversation
    var messages = await box.read("sunday-message-conversation-$conversationUUID");

    var newMessages = messages;

    sundayPrint(messages);

    /// Add the new message to the list of messages
    newMessages.add(newMessage);

    /// Persist the updated messages back to storage
    await box.write("sunday-message-conversation-$conversationUUID", newMessages);

    /// Log the successful addition of the new message
    sundayPrint("New message added to conversation: $conversationUUID");
  } catch (e) {
    /// Log the error and throw an exception if adding the message fails
    sundayPrint("Error adding new message: $e");
  }
}
