import 'package:shared_preferences_listener/shared_preferences_listener.dart';
import 'package:sunday_core/Print/print.dart';

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
    final prefs = SharedPreferencesListener();

    List<Map<String, dynamic>> conversationsList = prefs
        .read('sunday-message-conversations') as List<Map<String, dynamic>>;
    conversationsList = List<Map<String, dynamic>>.from(conversationsList);

    Map<String, dynamic>? conversationToDelete = conversationsList.firstWhere(
      (Map<String, dynamic> conv) => conv['uuid'] == conversationUUID,
      orElse: () => <String, dynamic>{},
    );

    if (conversationToDelete.isEmpty) {
      throw Exception('Conversation not found');
    }

    conversationsList.removeWhere(
        (Map<String, dynamic> conv) => conv['uuid'] == conversationUUID);

    await prefs.write('sunday-message-conversations', conversationsList);
    await prefs.remove('sunday-message-conversation-$conversationUUID');

    sundayPrint(
        'Conversation with UUID \'$conversationUUID\' deleted successfully');
  } catch (e) {
    sundayPrint('Error deleting conversation: $e');
    throw Exception('Error deleting conversation');
  }
}
