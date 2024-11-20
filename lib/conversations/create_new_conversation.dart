import 'package:sunday_conversations/schemas/conversation_schema.dart';
import 'package:sunday_conversations/schemas/message_shema.dart';
import 'package:sunday_core/Print/print.dart';
import 'package:sunday_get_storage/sunday_get_storage.dart';
import 'package:uuid/uuid.dart';

/// Creates a new conversation and stores it in local storage.
///
/// This function creates a new conversation with the provided details,
/// initializes it with a welcome message, and stores it in the local storage.
///
/// Parameters:
/// - [conversationName]: The name of the new conversation.
/// - [userId]: The unique identifier of the user creating the conversation.
/// - [description]: A brief description of the conversation.
/// - [groupName]: The name of the group (if applicable).
/// - [firstMessage]: The first message of the conversation.
/// Returns:
/// - [String] The UUID of the created conversation.
///
/// Throws an [Exception] if there's an error writing to GetStorage.
String CreateNewConversation({
  required String conversationName,
  required String userId,
  required String description,
  required String groupName,
  required String firstMessage,
}) {
  /// Initialize GetStorage for data persistence
  GetStorage box = GetStorage();

  /// Generate a unique identifier for the new conversation
  String conversationUUID = const Uuid().v4();

  /// Initialize the conversation with a welcome message
  var messageConv = [messageSchema(
      content: firstMessage,
      autoMessageId: "automessageid:conversation-start",
      isSender: true,
      reaction: [],
      distributed: true,
      seen: true)];

  /// Retrieve existing conversations list or initialize an empty list
  var conversationsList = box.read("sunday-message-conversations") ?? [];

  /// Ensure type safety by casting the list to List<Map<String, dynamic>>
  conversationsList = conversationsList.cast<Map<String, dynamic>>();

  /// Define the new conversation using the conversation schema
  var conv = conversationSchema(
      name: conversationName,
      description: description,
      userUuid: userId,
      notes: "",
      messagesPerBox: 25,
      isGroup: false,
      conversationUUID: conversationUUID.toString());

  /// Add the new conversation to the list
  conversationsList.add(conv);

  /// Persist the updated data to storage
  try {
    /// Write the updated conversations list
    box.write("sunday-message-conversations", conversationsList);

    /// Write the new conversation's initial message
    box.write(
        "sunday-message-conversation-$conversationUUID", messageConv);
  } catch (e) {
    /// Log the error for debugging purposes
    sundayPrint("Error writing to GetStorage: $e");

    /// Propagate the error to the caller
    throw Exception("Error writing to GetStorage");
  }

  /// Debug statements to verify data persistence
  sundayPrint(box.read("sunday-message-conversations"));
  sundayPrint(box.read("sunday-message-conversation-$userId"));

  return conversationUUID;
}
