import 'package:sunday_conversations/schemas/conversation_schema.dart';
import 'package:sunday_conversations/schemas/message_shema.dart';
import 'package:sunday_core/GetGtorage/get_storage.dart';
import 'package:sunday_core/Print/print.dart';
import 'package:uuid/uuid.dart';

/// Create a new conversation
Future<void> asyncCreateNewConversation({
  required String conversationName,
  required String userId,
  required String description,
  required String groupName,
}) async {
  // Initialize GetStorage
  SundayGetStorage box = SundayGetStorage();

  String conversationUUID = const Uuid().v4();

  // Initialize the conversation with a welcome message
  var messageConv = messageSchema(
      content: "",
      autoMessageId: "automessageid:conversation-start",
      isSender: false,
      reaction: [],
      distributed: true,
      seen: true);

  // get conversations list
  var conversationsList = await box.read("sunday-message-conversations") ?? [];

  // Ensure each item in the list is a Map<String, dynamic>
  conversationsList = conversationsList.cast<Map<String, dynamic>>();

  // define new conversation
  var conv = conversationSchema(
      name: conversationName,
      description: description,
      userUuid: userId,
      notes: "",
      messagesPerBox: 25,
      isGroup: false,
      conversationUUID: conversationUUID.toString());

  // add the conversation
  conversationsList.add(conv);

  // Add error handling for write operations
  try {
    // write conversations
    box.write("sunday-message-conversations", conversationsList);

    // write the new conversation
    box.write("sunday-message-conversation-$conversationUUID", messageConv);

    // catch in case of error
  } catch (e) {
    // print the error
    sundayPrint("Error writing to GetStorage: $e");

    // send to flutter the error
    throw Exception("Error writing to GetStorage");
  }

  // Debug statements to check data
  sundayPrint(box.read("sunday-message-conversations"));
  sundayPrint(box.read("sunday-message-conversation-$userId"));
}
