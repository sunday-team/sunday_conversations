import 'package:sunday_core/GetGtorage/get_storage.dart';
import 'package:sunday_core/Print/print.dart';

/// Edit a conversation
Future<void> asyncEditConversation({
  required String conversationUUID,
  required String property,
  required dynamic newValue,
}) async {
  try {
    // Initialize GetStorage
    final box = SundayGetStorage();

    // Get conversations list
    var conversationsList = await box.read("sunday-message-conversations") ?? [];

    // Ensure each item in the list is a Map<String, dynamic>
    conversationsList = List<Map<String, dynamic>>.from(conversationsList);

    // Find the conversation to edit
    var conversationToEdit = conversationsList.firstWhere(
      (conv) => conv['uuid'] == conversationUUID,
      orElse: () => null,
    );

    if (conversationToEdit == null) {
      throw Exception("Conversation not found");
    }

    // Update the specified property
    conversationToEdit[property] = newValue;

    // Update the 'updatedAt' timestamp
    conversationToEdit['updatedAt'] = DateTime.now().toString();

    // Write updated conversations list
    await box.write("sunday-message-conversations", conversationsList);

    sundayPrint("Conversation with UUID '$conversationUUID' edited successfully");
  } catch (e) {
    sundayPrint("Error editing conversation: $e");
    throw Exception("Error editing conversation");
  }
}
