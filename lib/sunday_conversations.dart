library sunday_conversations;

import 'dart:async';

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
    asyncCreateNewConversation(
        conversationName: conversationName,
        userId: userId,
        description: description,
        groupName: groupName);
  }

  void createNewGroupConversation({
    required String conversationName,
    required String userId,
    required String description,
    required String groupName,
    required List<Map<String, String>> users,
  }) {
    asyncCreateNewGroupConversation(
        conversationName: conversationName,
        userId: userId,
        description: description,
        groupName: groupName,
        users: users);
  }

  void addNewMessage({
    required String conversationUUID,
    required String content,
  }) {
    asyncAddNewMessage(
        conversationUUID: conversationUUID,
        content: content,
        isSender: false,
        reaction: []);
  }

  void deleteMessage({
    required String conversationUUID,
    required String messageId,
  }) {
    asyncDeleteMessage(
        conversationUUID: conversationUUID, messageId: messageId);
  }

  void editMessage({
    required String conversationUUID,
    required String messageId,
    required String key,
    required dynamic value,
  }) {
    asyncEditMessage(
        conversationUUID: conversationUUID,
        messageId: messageId,
        key: key,
        value: value);
  }

  void deleteConversation({required String conversationUUID}) {
    asyncDeleteConversation(conversationUUID: conversationUUID);
  }

  Stream<dynamic> streamConversation({required String conversationUUID}) {
    return asyncStreamConversation(conversationUUID).map((message) {
      sundayPrint('Received message: $message');
      return message;
    }).handleError((error) {
      sundayPrint('Error occurred: $error');
    }).transform(StreamTransformer.fromHandlers(handleDone: (sink) {
      sundayPrint('Stream closed');
      sink.close();
    }));
  }

  void editConversation({
    required String conversationUUID,
    required String property,
    required dynamic newValue,
  }) {
    asyncEditConversation(
        conversationUUID: conversationUUID,
        property: property,
        newValue: newValue);
  }
}
