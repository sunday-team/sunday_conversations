Map<String, dynamic> conversationSchema(
    {required String name,
    required String description,
    required String userUuid,
    required String notes,
    required int messagesPerBox,
    required bool isGroup,
    required String conversationUUID}) {
  DateTime now = DateTime.now();
  return {
    'schema-version': '1.0.0',
    'name': name,
    'description': description,
    'userUuid': userUuid,
    'createdAt': now,
    'updatedAt': now,
    'notes': notes,
    'infos': [],
    'messagesPerBox': messagesPerBox,
    'group': isGroup,
    'uuid': conversationUUID
  };
}
