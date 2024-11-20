import 'package:sunday_get_storage/sunday_get_storage.dart';
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
    /// Initialize GetStorage for data persistence
    final box = GetStorage();

    /// Retrieve the list of conversations from storage
    List<dynamic> rawList = box.read<List<dynamic>>('sunday-message-conversations') ?? <dynamic>[];

    /// Ensure type safety by casting the list to List<Map<String, dynamic>>
    List<Map<String, dynamic>> conversationsList = List<Map<String, dynamic>>.from(rawList);

    /// Find the index of the conversation to get the properties of
    int conversationIndex = conversationsList.indexWhere(
      (Map<String, dynamic> conv) => conv['uuid'] == conversationUUID,
    );

    /// Throw an exception if the conversation is not found
    if (conversationIndex == -1) {
      throw Exception('Conversation not found');
    }

    /// Log the successful retrieval
    sundayPrint(
        'Properties retrieved for conversation with UUID \'$conversationUUID\'');

    /// Return the properties of the conversation
    return Map<String, dynamic>.from(conversationsList[conversationIndex]);
  } catch (e) {
    /// Log the error and throw an exception if retrieving the properties fails
    sundayPrint('Error getting conversation properties: $e');
    throw Exception('Error getting conversation properties');
  }
}
