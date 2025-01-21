// ignore_for_file: inference_failure_on_function_invocation, inference_failure_on_collection_literal

import 'package:sunday_conversations/schemas/conversation_schema.dart';
import 'package:sunday_conversations/schemas/message_shema.dart';
import 'package:shared_preferences_listener/shared_preferences_listener.dart';
import 'package:sunday_core/Print/print.dart';
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
/// - [properties]: Optional additional properties to store with the conversation.
/// Returns:
/// - [String] The UUID of the created conversation.
///
/// Throws an [Exception] if there's an error writing to GetStorage.
Future<String> asyncCreateNewConversation({
  required String conversationName,
  required String userId,
  required String description,
  required String groupName,
  dynamic firstMessage,
  List<Map<String, dynamic>>? properties,
}) async {
  try {
    final prefs = SharedPreferencesListener();
    String conversationUUID = const Uuid().v4();

    var firstMessageObject = messageSchema(
      content: firstMessage is String ? firstMessage : '',
      autoMessageId: 'automessageid:conversation-start',
      isSender: true,
      reaction: [],
      distributed: true,
      seen: true,
    );

    var messageConv = [];

    if (firstMessage != null) {
      messageConv.add(firstMessageObject);
    }

    var rawList = prefs.read('sunday-message-conversations') ?? [];
    sundayPrint('Raw conversations list type: ${rawList.runtimeType}');
    sundayPrint('Raw conversations list content: $rawList');

    List<Map<String, dynamic>> conversationsList;
    try {
      conversationsList = List<Map<String, dynamic>>.from(rawList as List);
    } catch (castError) {
      sundayPrint('Failed to cast conversations list: ${castError.toString()}');
      sundayPrint('Raw list content that failed casting: $rawList');
      rethrow;
    }

    var conv = conversationSchema(
      name: conversationName,
      description: description,
      userUuid: userId,
      notes: '',
      messagesPerBox: 25,
      isGroup: false,
      conversationUUID: conversationUUID,
      properties: properties,
    );

    sundayPrint('Generated conversation schema: $conv');
    sundayPrint('Conversation schema type: ${conv.runtimeType}');

    try {
      conversationsList.add(conv);
    } catch (addError) {
      sundayPrint('Failed to add conversation to list: ${addError.toString()}');
      sundayPrint('Conversation that failed to add: $conv');
      sundayPrint('Current conversations list: $conversationsList');
      rethrow;
    }

    try {
      await prefs.write('sunday-message-conversations', conversationsList);
    } catch (writeError) {
      sundayPrint(
          'Failed to write conversations list: ${writeError.toString()}');
      sundayPrint('Data that failed to write: $conversationsList');
      rethrow;
    }

    try {
      await prefs.write(
          'sunday-message-conversation-$conversationUUID', messageConv);
    } catch (writeError) {
      sundayPrint(
          'Failed to write message conversation: ${writeError.toString()}');
      sundayPrint('Message conversation that failed to write: $messageConv');
      rethrow;
    }

    sundayPrint('Created conversation with UUID: $conversationUUID');
    sundayPrint('Full conversation details: ${conv.toString()}');
    return conversationUUID;
  } catch (e) {
    sundayPrint('Error creating conversation: ${e.toString()}');
    sundayPrint('Error type: ${e.runtimeType}');
    sundayPrint('Stack trace: ${StackTrace.current}');
    sundayPrint('Input parameters:');
    sundayPrint(
        '  conversationName: $conversationName (${conversationName.runtimeType})');
    sundayPrint('  userId: $userId (${userId.runtimeType})');
    sundayPrint('  description: $description (${description.runtimeType})');
    sundayPrint('  groupName: $groupName (${groupName.runtimeType})');
    sundayPrint('  firstMessage: $firstMessage (${firstMessage.runtimeType})');
    sundayPrint('  properties: $properties (${properties?.runtimeType})');
    throw Exception('Error creating conversation: $e');
  }
}
