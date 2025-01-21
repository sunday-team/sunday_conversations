/// Sunday Conversations library
library;

import 'dart:async';

import 'package:shared_preferences_listener/shared_preferences_listener.dart';
import 'package:sunday_conversations/conversations/create_new_conversation.dart';
import 'package:shared_preferences_listener/shared_preferences_listener.dart';
import 'package:sunday_conversations/conversations/get_conversation.dart';
import 'package:sunday_core/Print/print.dart';
import 'conversations/create_new_group_conversation.dart';
import 'conversations/delete_conversation.dart';
import 'conversations/edit_conversation.dart';
import 'conversations/stream_conversation.dart';
import 'messages/add_new_message.dart';
import 'messages/delete_messages.dart';
import 'messages/edit_message.dart';

/// A Calculator class for demonstration purposes.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

/// A class to initialize and manage Sunday Conversations
class SundayConversations {
  final _prefs = SharedPreferencesListener();

  Future<void> init() async {
    await _prefs.init();
    sundayPrint('Sunday Conversations initialized');
  }

  /// Create a new conversation
  ///
  /// [conversationName] The name of the conversation
  /// [userId] The ID of the user creating the conversation
  /// [description] A description of the conversation
  /// [groupName] The name of the group the conversation belongs to
  /// [firstMessage] The first message of the conversation
  Future<String> createNewConversation(
      {required String conversationName,
      required String userId,
      required String description,
      required String groupName,
      dynamic firstMessage,
      List<Map<String, dynamic>>? properties}) async {
    return await asyncCreateNewConversation(
        properties: properties,
        conversationName: conversationName,
        userId: userId,
        description: description,
        groupName: groupName,
        firstMessage: firstMessage);
  }

  /// Create a new group conversation
  ///
  /// [conversationName] The name of the group conversation
  /// [userId] The ID of the user creating the group conversation
  /// [description] A description of the group conversation
  /// [groupName] The name of the group
  /// [users] A list of users to be added to the group conversation
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

  /// Add a new message to a conversation
  ///
  /// [conversationUUID] The UUID of the conversation
  /// [content] The content of the message
  Future<void> addNewMessage({
    required String conversationUUID,
    required String content,
    required bool isSender,
  }) async {
    await asyncAddNewMessage(
        conversationUUID: conversationUUID,
        content: content,
        isSender: isSender,
        reaction: []);
  }

  /// Delete a message from a conversation
  ///
  /// [conversationUUID] The UUID of the conversation
  /// [messageId] The ID of the message to be deleted
  void deleteMessage({
    required String conversationUUID,
    required String messageId,
  }) {
    asyncDeleteMessage(
        conversationUUID: conversationUUID, messageId: messageId);
  }

  /// Edit a message in a conversation
  ///
  /// [conversationUUID] The UUID of the conversation
  /// [messageId] The ID of the message to be edited
  /// [key] The key of the property to be edited
  /// [value] The new value for the property
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

  /// Delete a conversation
  ///
  /// [conversationUUID] The UUID of the conversation to be deleted
  void deleteConversation({required String conversationUUID}) {
    asyncDeleteConversation(conversationUUID: conversationUUID);
  }

  /// Stream a conversation
  ///
  /// [conversationUUID] The UUID of the conversation to stream
  ///
  /// Returns a [Stream] of messages from the conversation
  Stream<dynamic> streamConversation({required String conversationUUID}) {
    return asyncStreamConversation(conversationUUID).map((message) {
      sundayPrint('Received message: $message');
      return message;
    }).handleError((Object error) {
      sundayPrint('Error occurred: $error');
    }).transform(StreamTransformer.fromHandlers(handleDone: (sink) {
      sundayPrint('Stream closed');
      sink.close();
    }));
  }

  /// Edit a conversation's properties
  ///
  /// [conversationUUID] The UUID of the conversation to be edited
  /// [property] The property of the conversation to be edited
  /// [newValue] The new value for the property
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

  /// Get a conversation's properties
  ///
  /// [conversationUUID] The UUID of the conversation to get the properties of
  ///
  /// Returns a [Map] of the conversation's properties
  Map<String, dynamic> getConversationProperties({
    required String conversationUUID,
  }) {
    return asyncGetConversationProperties(conversationUUID);
  }
}
