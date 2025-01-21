import 'dart:async';
import 'package:shared_preferences_listener/shared_preferences_listener.dart';
import 'package:sunday_core/Print/print.dart';

/// Streams messages from a specific conversation.
///
/// This function creates a stream of messages for a given conversation,
/// identified by its UUID. It listens to changes in the local storage
/// and emits messages as they are updated.
///
/// Parameters:
/// - [conversationUUID]: The unique identifier of the conversation to stream.
///
/// Returns:
/// A [Stream<dynamic>] that emits messages from the specified conversation.
/// If no messages are found or an error occurs, it returns an empty stream.
Stream<dynamic> asyncStreamConversation(String conversationUUID) {
  final prefs = SharedPreferencesListener();
  final key = 'sunday-message-conversation-$conversationUUID';
  final controller = StreamController<dynamic>();

  prefs.listenKey(key, (value) {
    if (value != null) {
      if (value is Iterable) {
        for (var message in value) {
          controller.add(message);
        }
      }
    } else {
      sundayPrint('No messages found for conversation: $conversationUUID');
    }
  });

  return controller.stream.handleError((Object error) {
    sundayPrint('Error streaming conversation: $error');
  });
}
