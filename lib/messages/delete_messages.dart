import 'package:sunday_core/GetGtorage/get_storage.dart';
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
    // Initialize GetStorage
    final box = SundayGetStorage();

    /// Retrieves existing messages for the conversation from local storage.
    /// Returns an empty list if no messages are found.
    var messages =
        await box.read("sunday-message-conversation-$conversationUUID") ?? [];

    /// Ensures that each item in the messages list is of type Map<String, dynamic>.
    /// This step is crucial for type safety and proper data handling.
    messages = List<Map<String, dynamic>>.from(messages);

    /// Finds the index of the message to be deleted.
    /// Returns -1 if the message is not found.
    int indexToDelete =
        messages.indexWhere((message) => message['messageId'] == messageId);

    if (indexToDelete == -1) {
      throw Exception("Message not found");
    }

    /// Removes the message from the list at the found index.
    messages.removeAt(indexToDelete);

    /// Writes the updated messages back to local storage.
    await box.write("sunday-message-conversation-$conversationUUID", messages);

    /// Logs a success message with the deleted message's ID and conversation UUID.
    sundayPrint(
        "Message with ID '$messageId' deleted from conversation: $conversationUUID");
  } catch (e) {
    /// Logs the error and rethrows an exception with a generic error message.
    sundayPrint("Error deleting message: $e");
    throw Exception("Error deleting message");
  }
}
