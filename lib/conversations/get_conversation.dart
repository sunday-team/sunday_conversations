import 'package:shared_preferences_listener/shared_preferences_listener.dart';
import 'package:sunday_core/Print/print.dart';

/// Gets the properties of a conversation.
///
/// This function retrieves the properties of a conversation identified by its UUID.
///
/// Parameters:
/// - [conversationUUID]: The unique identifier of the conversation to get the properties of.
///
/// Returns a [Map<String, dynamic>] containing the conversation properties.
/// Throws an [Exception] if the conversation is not found or if there's an error during the retrieval process.
Map<String, dynamic> asyncGetConversationProperties(String conversationUUID) {
  try {
    final prefs = SharedPreferencesListener();

    var rawList = prefs.read('sunday-message-conversations') ?? [];
    List<dynamic> conversationsList = List<dynamic>.from(rawList as Iterable<dynamic>);

    int conversationIndex = conversationsList.indexWhere(
      (dynamic conv) => conv['uuid'] == conversationUUID,
    );

    if (conversationIndex == -1) {
      throw Exception('Conversation not found');
    }

    sundayPrint(
        'Properties retrieved for conversation with UUID \'$conversationUUID\'');
    return Map<String, dynamic>.from(conversationsList[conversationIndex] as Map<dynamic, dynamic>);
  } catch (e) {
    sundayPrint('Error getting conversation properties: $e');
    throw Exception('Error getting conversation properties');
  }
}
