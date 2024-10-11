import 'package:sunday_conversations/schemas/message_shema.dart';
import 'package:sunday_core/GetGtorage/get_storage.dart';
import 'package:sunday_core/Print/print.dart';

/// Add a new message to a conversation
Future<void> asyncAddNewMessage({
  required String conversationUUID,
  required String content,
  required bool isSender,
  required List<Map<String, dynamic>> reaction,
  List<Map<String, String>>? attachments, // List of attachments
}) async {
  try {
    // Initialize GetStorage
    final box = SundayGetStorage();

    // Create a new message using the message schema
    var newMessage = messageSchema(
      content: content,
      autoMessageId: "automessageid:new-message",
      isSender: isSender,
      reaction: reaction,
      distributed: true,
      seen: false,
      attachments: attachments, // Include attachments in the schema
    );

    // Get the existing messages for the conversation
    var messages = await box.read("sunday-message-conversation-$conversationUUID") ?? [];

    // Ensure each item in the list is a Map<String, dynamic>
    messages = List<Map<String, dynamic>>.from(messages);

    // Add the new message to the list
    messages.add(newMessage);

    // Write the updated messages back to storage
    await box.write("sunday-message-conversation-$conversationUUID", messages);

    sundayPrint("New message added to conversation: $conversationUUID");
  } catch (e) {
    sundayPrint("Error adding new message: $e");
    throw Exception("Error adding new message");
  }
}
