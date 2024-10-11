library sunday_conversations;

import 'package:get_storage/get_storage.dart';

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
    print('Sunday Conversations initialized');
  }

  void createNewConversation() {
    asyncCreateNewConversation();
  }

  void createNewGroupConversation() {
    asyncCreateNewGroupConversation();
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

  void deleteConversation() {
    asyncDeleteConversation();
  }

  void streamConversation() {
    asyncStreamConversation();
  }

  void editConversation() {
    asyncEditConversation();
  }
}
