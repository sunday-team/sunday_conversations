Map<String, dynamic> conversationSchema(
    {required String name,
    required String description,
    required String userUuid,
    required String notes,
    required int messagesPerBox,
    required bool isGroup,
    required String conversationUUID,
    List<dynamic>? infos,
    List<Map<String, dynamic>>? properties}) {
  String now = DateTime.now().toIso8601String();
  return {
    'schema-version': '1.0.0',
    'name': name,
    'description': description,
    'userUuid': userUuid,
    'createdAt': now,
    'updatedAt': now,
    'notes': notes,
    'infos': infos,
    'properties': properties,
    'messagesPerBox': messagesPerBox,
    'group': isGroup,
    'uuid': conversationUUID
  };
}
