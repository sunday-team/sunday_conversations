library sunday_conversations;

import 'package:get_storage/get_storage.dart';
import 'package:sunday_core/Print/print.dart';
import 'conversations/create_new_conversation.dart';
import 'conversations/create_new_group_conversation.dart';
import 'conversations/delete_conversation.dart';
import 'conversations/edit_conversation.dart';
import 'conversations/stream_conversation.dart';
import 'messages/add_new_message.dart';
import 'messages/delete_messages.dart';
import 'messages/edit_message.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

/// A class to intialize Sunday Conversations
class SundayConversations {
  /// intialize Sunday Conversations
  void init() {
    GetStorage.init();
    sundayPrint('Sunday Conversations initialized');
  }

  void createNewConversation({
    required String conversationName,
    required String userId,
    required String description,
    required String groupName,
  }) {
    asyncCreateNewConversation(conversationName: conversationName, userId: userId, description: description, groupName: groupName);
  }

  void createNewGroupConversation({
    required String conversationName,
    required String userId,
    required String description,
    required String groupName,
    required List<Map<String, String>> users,
  }) {
    asyncCreateNewGroupConversation(conversationName: conversationName, userId: userId, description: description, groupName: groupName, users: users);
  }

  void addNewMessage() {
    asyncAddNewMessage();
  }

  void deleteMessage() {
    asyncDeleteMessage();
  }

  void editMessage() {
    asyncEditMessage();
  }

  void deleteConversation({required String conversationUUID}) {
    asyncDeleteConversation(conversationUUID: conversationUUID);
  }

  void streamConversation() {
    asyncStreamConversation();
  }

  void editConversation() {
    asyncEditConversation();
  }
}
