Map<String, dynamic> conversationSchema(String name, String description, String userUuid, String notes) {
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
    'messagesPerBox': 25,
  };
}
