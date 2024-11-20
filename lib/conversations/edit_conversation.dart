import 'package:sunday_get_storage/sunday_get_storage.dart';
import 'package:sunday_core/Print/print.dart';

/// Edits a specific property of a conversation.
///
/// This function updates a single property of a conversation identified by its UUID.
/// If the property doesn't exist, it will be created.
/// It also updates the 'updatedAt' timestamp of the conversation.
///
/// Parameters:
/// - [conversationUUID]: The unique identifier of the conversation to be edited.
/// - [property]: The name of the property to be updated or created.
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
    final box = GetStorage();

    /// Retrieve the list of conversations from storage
    List<Map<String, dynamic>> conversationsList =
        box.read<List<Map<String, dynamic>>>('sunday-message-conversations') ?? <Map<String, dynamic>>[];

    /// Find the index of the conversation to edit
    final int conversationIndex = conversationsList.indexWhere(
      (Map<String, dynamic> conv) => conv['uuid'] == conversationUUID,
    );

    /// Throw an exception if the conversation is not found
    if (conversationIndex == -1) {
      throw Exception('Conversation not found');
    }

    /// Create or update the specified property with the new value
    conversationsList[conversationIndex][property] = newValue;

    /// Update the 'updatedAt' timestamp to reflect the recent change
    conversationsList[conversationIndex]['updatedAt'] = DateTime.now().toString();

    /// Persist the updated conversations list back to storage
    await box.write('sunday-message-conversations', conversationsList);

    /// Log the successful edit operation
    sundayPrint(
        'Conversation with UUID \'$conversationUUID\' edited successfully');
  } catch (e) {
    /// Log the error and throw an exception if editing the conversation fails
    sundayPrint('Error editing conversation: $e');
    throw Exception('Error editing conversation');
  }
}
