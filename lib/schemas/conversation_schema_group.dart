Map<String, dynamic> conversationSchemaGroup({
  required String name,
  required String description,
  required List<Map<String, dynamic>> userUuid,
  required String notes,
  required int messagesPerBox,
  required bool isGroup,
  required String conversationUUID,
}) {
  DateTime now = DateTime.now();
  return {
    'schema-version': '1.0.0',
    'name': name,
    'description': description,
    'users': userUuid,
    'createdAt': now,
    'updatedAt': now,
    'notes': notes,
    'infos': [],
    'messagesPerBox': messagesPerBox,
    'group': isGroup,
    'uuid': conversationUUID
  };
}
