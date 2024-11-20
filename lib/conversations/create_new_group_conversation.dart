import 'package:sunday_conversations/schemas/conversation_schema.dart';
import 'package:sunday_conversations/schemas/message_shema_groups.dart';
import 'package:sunday_core/Print/print.dart';
import 'package:sunday_get_storage/sunday_get_storage.dart';
import 'package:uuid/uuid.dart';

/// Creates a new group conversation and stores it in the local storage.
///
/// This function creates a new group conversation with the provided details,
/// initializes it with a welcome message, and stores it in the local storage
/// using GetStorage.
///
/// Parameters:
/// - [conversationName]: The name of the new group conversation.
/// - [userId]: The ID of the user creating the conversation.
/// - [description]: A brief description of the group conversation.
/// - [groupName]: The name of the group.
/// - [users]: A list of users participating in the group conversation.
///   Each user is represented by a map containing their details.
///
/// Throws an [Exception] if there's an error writing to GetStorage.
Future<void> asyncCreateNewGroupConversation({
  required String conversationName,
  required String userId,
  required String description,
  required String groupName,
  required List<Map<String, String>> users,
}) async {
  try {
    // Initialize GetStorage
    final box = GetStorage();

    // Generate a unique identifier for the conversation
    String conversationUUID = const Uuid().v4();

    // Initialize the conversation with a welcome message
    var messageConv = messageSchemaGroup(
      content: "",
      isSender: false,
      reaction: users
          .map((user) => {
                "userId": user["userId"],
                "seen": false, // Default value for seen
                "distributed": true, // Default value for distributed
              })
          .toList(),
      autoMessageId: "automessageid:conversation-start",
      users: users,
    );

    // Get existing conversations list
    var conversationsList =
        await box.read("sunday-message-conversations") ?? [];

    // Ensure each item in the list is a Map<String, dynamic>
    conversationsList = List<Map<String, dynamic>>.from(conversationsList);

    // Define new conversation
    var conv = conversationSchema(
      name: conversationName,
      description: description,
      userUuid: userId,
      notes: "",
      messagesPerBox: 25,
      isGroup: true,
      conversationUUID: conversationUUID,
    );

    // Add the new conversation to the list
    conversationsList.add(conv);

    // Write updated conversations list
    await box.write("sunday-message-conversations", conversationsList);

    // Write the new conversation messages
    await box.write(
        "sunday-message-conversation-$conversationUUID", messageConv);
  } catch (e) {
    // Log the error
    sundayPrint("Error writing to GetStorage: $e");

    // Throw an exception to be handled by the caller
    throw Exception("Error writing to GetStorage");
  }
}
