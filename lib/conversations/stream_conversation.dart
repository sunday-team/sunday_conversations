import 'dart:async';
import 'package:sunday_core/GetGtorage/get_storage.dart';
import 'package:sunday_core/Print/print.dart';

/// Stream a conversation
Stream<dynamic> asyncStreamConversation(String conversationUUID) {
  final box = SundayGetStorage();
  final key = "sunday-message-conversation-$conversationUUID";
  
  return box.listenKey(key).asyncExpand((messages) {
    if (messages != null) {
      return Stream.fromIterable(messages);
    } else {
      sundayPrint("No messages found for conversation: $conversationUUID");
      return Stream<dynamic>.empty();
    }
  }).handleError((error) {
    sundayPrint("Error streaming conversation: $error");
    return Stream<dynamic>.empty();
  });
}