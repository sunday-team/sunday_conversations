/// Creates a conversation schema for a group chat.
///
/// This function generates a standardized structure for group conversations,
/// including metadata and user information.
///
/// Parameters:
/// - [name]: The name of the conversation group.
/// - [description]: A brief description of the conversation group.
/// - [userUuid]: A list of user UUIDs participating in the conversation.
/// - [notes]: Additional notes about the conversation.
/// - [messagesPerBox]: The number of messages to display per message box.
/// - [isGroup]: A boolean indicating whether this is a group conversation.
/// - [conversationUUID]: A unique identifier for the conversation.
///
/// Returns a [Map<String, dynamic>] representing the conversation structure.
Map<String, dynamic> conversationSchemaGroup({
  required String name,
  required String description,
  required List<Map<String, dynamic>> userUuid,
  required String notes,
  required int messagesPerBox,
  required bool isGroup,
  required String conversationUUID,
}) {
  /// Get the current timestamp for creation and update times.
  DateTime now = DateTime.now();

  return {
    'schema-version': '1.0.0',
    'name': name,
    'description': description,
    'users': userUuid,
    'createdAt': now,
    'updatedAt': now,
    'notes': notes,
    'infos': [],
    'messagesPerBox': messagesPerBox,
    'group': isGroup,
    'uuid': conversationUUID
  };
}
