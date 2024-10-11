import 'package:sunday_core/GetGtorage/get_storage.dart';
import 'package:sunday_core/Print/print.dart';

/// Edits a specific property of a conversation.
///
/// This function updates a single property of a conversation identified by its UUID.
/// It also updates the 'updatedAt' timestamp of the conversation.
///
/// Parameters:
/// - [conversationUUID]: The unique identifier of the conversation to be edited.
/// - [property]: The name of the property to be updated.
/// - [newValue]: The new value to be set for the specified property.
///
/// Throws an [Exception] if the conversation is not found or if there's an error during the editing process.
Future<void> asyncEditConversation({
  required String conversationUUID,
  required String property,
  required dynamic newValue,
}) async {
  try {
    /// Initialize GetStorage for data persistence
    final box = SundayGetStorage();

    /// Retrieve the list of conversations from storage
    var conversationsList =
        await box.read("sunday-message-conversations") ?? [];

    /// Ensure type safety by casting the list to List<Map<String, dynamic>>
    conversationsList = List<Map<String, dynamic>>.from(conversationsList);

    /// Find the conversation to edit based on the provided UUID
    var conversationToEdit = conversationsList.firstWhere(
      (conv) => conv['uuid'] == conversationUUID,
      orElse: () => null,
    );

    /// Throw an exception if the conversation is not found
    if (conversationToEdit == null) {
      throw Exception("Conversation not found");
    }

    /// Update the specified property with the new value
    conversationToEdit[property] = newValue;

    /// Update the 'updatedAt' timestamp to reflect the recent change
    conversationToEdit['updatedAt'] = DateTime.now().toString();

    /// Persist the updated conversations list back to storage
    await box.write("sunday-message-conversations", conversationsList);

    /// Log the successful edit operation
    sundayPrint(
        "Conversation with UUID '$conversationUUID' edited successfully");
  } catch (e) {
    /// Log the error and throw an exception if editing the conversation fails
    sundayPrint("Error editing conversation: $e");
    throw Exception("Error editing conversation");
  }
}
