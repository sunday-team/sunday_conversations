import 'package:sunday_get_storage/sunday_get_storage.dart';
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
    // Initialize GetStorage
    final box = GetStorage();

    // Get the existing messages for the conversation
    var messages =
        await box.read("sunday-message-conversation-$conversationUUID") ?? [];

    // Ensure each item in the list is a Map<String, dynamic>
    messages = List<Map<String, dynamic>>.from(messages);

    // Find the index of the message to edit
    int indexToEdit =
        messages.indexWhere((message) => message['messageId'] == messageId);

    if (indexToEdit == -1) {
      throw Exception("Message not found");
    }

    // Edit the specified key-value pair in the message
    messages[indexToEdit]["content"]["content"] = value;

    // Update the 'updatedAt' timestamp
    messages[indexToEdit]['updatedAt'] = DateTime.now().toString();

    // Write the updated messages back to storage
    await box.write("sunday-message-conversation-$conversationUUID", messages);

    /// Logs the successful edit operation
    sundayPrint(
        "Message with ID '$messageId' edited in conversation: $conversationUUID");
  } catch (e) {
    /// Logs any errors that occur during the edit process
    sundayPrint("Error editing message: $e");
    throw Exception("Error editing message");
  }
}
