import 'package:sunday_core/Print/print.dart';
import 'package:sunday_get_storage/sunday_get_storage.dart';

/// Deletes a conversation from storage based on its UUID.
///
/// This function removes the specified conversation from the list of conversations
/// and deletes its associated messages from storage.
///
/// [conversationUUID] The unique identifier of the conversation to be deleted.
///
/// Throws an [Exception] if the conversation is not found or if there's an error during deletion.
Future<void> asyncDeleteConversation({required String conversationUUID}) async {
  try {
    // Initialize GetStorage
    final box = GetStorage();

    // Get conversations list
    var conversationsList =
        await box.read("sunday-message-conversations") ?? [];

    // Ensure each item in the list is a Map<String, dynamic>
    conversationsList = List<Map<String, dynamic>>.from(conversationsList);

    /// Finds the conversation to delete based on the provided UUID.
    ///
    /// Returns null if no matching conversation is found.
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

    sundayPrint(
        "Conversation with UUID '$conversationUUID' deleted successfully");
  } catch (e) {
    sundayPrint("Error deleting conversation: $e");
    throw Exception("Error deleting conversation");
  }
}
