import 'package:sunday_core/GetGtorage/get_storage.dart';
import 'package:sunday_core/Print/print.dart';

/// Delete a message from a conversation
Future<void> asyncDeleteMessage({
  required String conversationUUID,
  required String messageId,
}) async {
  try {
    // Initialize GetStorage
    final box = SundayGetStorage();

    // Get the existing messages for the conversation
    var messages = await box.read("sunday-message-conversation-$conversationUUID") ?? [];

    // Ensure each item in the list is a Map<String, dynamic>
    messages = List<Map<String, dynamic>>.from(messages);

    // Find the index of the message to delete
    int indexToDelete = messages.indexWhere((message) => message['messageId'] == messageId);

    if (indexToDelete == -1) {
      throw Exception("Message not found");
    }

    // Remove the message from the list
    messages.removeAt(indexToDelete);

    // Write the updated messages back to storage
    await box.write("sunday-message-conversation-$conversationUUID", messages);

    sundayPrint("Message with ID '$messageId' deleted from conversation: $conversationUUID");
  } catch (e) {
    sundayPrint("Error deleting message: $e");
    throw Exception("Error deleting message");
  }
}
