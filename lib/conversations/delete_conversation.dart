import 'package:sunday_core/GetGtorage/get_storage.dart';
import 'package:sunday_core/Print/print.dart';

/// Delete a conversation
Future<void> asyncDeleteConversation({required String conversationUUID}) async {
  try {
    // Initialize GetStorage
    final box = SundayGetStorage();

    // Get conversations list
    var conversationsList = await box.read("sunday-message-conversations") ?? [];

    // Ensure each item in the list is a Map<String, dynamic>
    conversationsList = List<Map<String, dynamic>>.from(conversationsList);

    // Find the conversation to delete
    var conversationToDelete = conversationsList.firstWhere(
      (conv) => conv['uuid'] == conversationUUID,
      orElse: () => null,
    );

    if (conversationToDelete == null) {
      throw Exception("Conversation not found");
    }

    // Remove the conversation from the list
    conversationsList.removeWhere((conv) => conv['uuid'] == conversationUUID);

    // Write updated conversations list
    await box.write("sunday-message-conversations", conversationsList);

    // Delete the conversation messages
    String conversationName = conversationToDelete['name'];
    await box.remove("sunday-message-conversation-$conversationName");

    sundayPrint("Conversation with UUID '$conversationUUID' deleted successfully");
  } catch (e) {
    sundayPrint("Error deleting conversation: $e");
    throw Exception("Error deleting conversation");
  }
}
