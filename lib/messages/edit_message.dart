import 'package:sunday_core/GetGtorage/get_storage.dart';
import 'package:sunday_core/Print/print.dart';

/// Edit a message
Future<void> asyncEditMessage({
  required String conversationUUID,
  required String messageId,
  required String key,
  required dynamic value,
}) async {
  try {
    // Initialize GetStorage
    final box = SundayGetStorage();

    // Get the existing messages for the conversation
    var messages = await box.read("sunday-message-conversation-$conversationUUID") ?? [];

    // Ensure each item in the list is a Map<String, dynamic>
    messages = List<Map<String, dynamic>>.from(messages);

    // Find the index of the message to edit
    int indexToEdit = messages.indexWhere((message) => message['messageId'] == messageId);

    if (indexToEdit == -1) {
      throw Exception("Message not found");
    }

    // Edit the specified key-value pair in the message
    messages[indexToEdit][key] = value;

    // Update the 'updatedAt' timestamp
    messages[indexToEdit]['updatedAt'] = DateTime.now().toString();

    // Write the updated messages back to storage
    await box.write("sunday-message-conversation-$conversationUUID", messages);

    sundayPrint("Message with ID '$messageId' edited in conversation: $conversationUUID");
  } catch (e) {
    sundayPrint("Error editing message: $e");
    throw Exception("Error editing message");
  }
}
