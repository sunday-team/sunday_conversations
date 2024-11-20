import 'dart:async';
import 'package:sunday_core/Print/print.dart';
import 'package:sunday_get_storage/sunday_get_storage.dart';

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
  /// Initialize the storage box for accessing conversation data.
  final box = GetStorage();

  /// Construct the key for accessing the specific conversation's messages.
  final key = "sunday-message-conversation-$conversationUUID";

  /// Create and return a stream of messages.
  final controller = StreamController<dynamic>();

  box.listenKey(key, (value) {
    if (value != null) {
      /// If messages exist, add them to the stream
      for (var message in value) {
        controller.add(message);
      }
    } else {
      /// Log a message if no messages are found for the conversation.
      sundayPrint("No messages found for conversation: $conversationUUID");
    }
  });

  return controller.stream.handleError((error) {
    /// Log any errors that occur during the streaming process.
    sundayPrint("Error streaming conversation: $error");
  });
}
