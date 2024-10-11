import 'package:sunday_conversations/schemas/conversation_schema.dart';
import 'package:sunday_conversations/schemas/message_shema_groups.dart';
import 'package:sunday_core/GetGtorage/get_storage.dart';
import 'package:sunday_core/Print/print.dart';
import 'package:uuid/uuid.dart';

/// Create a new group conversation
Future<void> asyncCreateNewGroupConversation(
    {required String conversationName,
    required String userId,
    required String description,
    required String groupName,
    required List<Map<String, String>> users}) async {
  try {
    // Initialize GetStorage
    final box = SundayGetStorage();

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
        users: users);

    // Get conversations list
    var conversationsList = await box.read("sunday-message-conversations") ?? [];

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
        conversationUUID: conversationUUID);

    // Add the conversation
    conversationsList.add(conv);

    // Write conversations
    await box.write("sunday-message-conversations", conversationsList);

    // Write the new conversation
    await box.write("sunday-message-conversation-$conversationUUID", messageConv);
  } catch (e) {
    // Print the error
    sundayPrint("Error writing to GetStorage: $e");

    // Send to Flutter the error
    throw Exception("Error writing to GetStorage");
  }
}
