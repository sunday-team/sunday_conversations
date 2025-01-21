import 'package:shared_preferences_listener/shared_preferences_listener.dart';
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
    final prefs = SharedPreferencesListener();
    var conversationsList = prefs.read('sunday-message-conversations') ?? [];

    final conversationIndex = conversationsList.indexWhere(
      (conv) => conv['uuid'] == conversationUUID,
    );

    if (conversationIndex == -1) {
      throw Exception('Conversation not found');
    }

    conversationsList[conversationIndex][property] = newValue;
    conversationsList[conversationIndex]['updatedAt'] =
        DateTime.now().toString();

    await prefs.write('sunday-message-conversations', conversationsList);

    sundayPrint(
        'Conversation with UUID \'$conversationUUID\' edited successfully');
  } catch (e) {
    sundayPrint('Error editing conversation: $e');
    throw Exception('Error editing conversation');
  }
}
