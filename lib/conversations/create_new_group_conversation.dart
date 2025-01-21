import 'package:sunday_conversations/schemas/conversation_schema.dart';
import 'package:sunday_conversations/schemas/message_shema_groups.dart';
import 'package:shared_preferences_listener/shared_preferences_listener.dart';
import 'package:sunday_core/Print/print.dart';
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
    final prefs = SharedPreferencesListener();
    String conversationUUID = const Uuid().v4();

    var messageConv = messageSchemaGroup(
      content: '',
      isSender: false,
      reaction: users
          .map((user) => {
                'userId': user['userId'],
                'seen': false,
                'distributed': true,
              })
          .toList(),
      autoMessageId: 'automessageid:conversation-start',
      users: users,
    );

    var conversationsList = prefs.read('sunday-message-conversations') ?? [];
    conversationsList = List<dynamic>.from(conversationsList as List<dynamic>);

    var conv = conversationSchema(
      name: conversationName,
      description: description,
      userUuid: userId,
      notes: '',
      messagesPerBox: 25,
      isGroup: true,
      conversationUUID: conversationUUID,
    );

    conversationsList.add(conv);

    await prefs.write('sunday-message-conversations', conversationsList);
    await prefs.write(
        'sunday-message-conversation-$conversationUUID', messageConv);
  } catch (e) {
    sundayPrint('Error writing to SharedPreferences: $e');
    throw Exception('Error writing to SharedPreferences');
  }
}
