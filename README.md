# Sunday Conversations

Une bibliothèque Flutter pour gérer facilement les conversations et les messages dans votre application.

## Fonctionnalités

- Création et gestion de conversations individuelles et de groupes
- Système de messagerie complet avec support pour :
  - Envoi et réception de messages
  - Édition et suppression de messages
  - Réactions aux messages
  - Pièces jointes
  - Indicateurs de lecture et de distribution
- Stockage local persistant des conversations et messages
- Streaming en temps réel des mises à jour de conversation
- Support multilingue
- Gestion efficace de la mémoire avec pagination des messages

## Pour commencer

1. Ajoutez la dépendance à votre fichier `pubspec.yaml` :

```
dependencies:
  sunday_conversations: ^0.1.3
```

2. Importez le package :

```dart
import 'package:sunday_conversations/sunday_conversations.dart';
```

3. Initialisez Sunday Conversations :

```dart
void main() {
  final sundayConversations = SundayConversations();
  sundayConversations.init();
}
```

## Utilisation

### Créer une nouvelle conversation

```dart
String conversationId = sundayConversations.createNewConversation(
  conversationName: "Ma conversation",
  userId: "user123",
  description: "Une description",
  groupName: "Groupe principal",
  firstMessage: "Premier message"
);
```

### Ajouter un message

```dart
await sundayConversations.addNewMessage(
  conversationUUID: conversationId,
  content: "Bonjour !",
  isSender: true
);
```

### Écouter les mises à jour d'une conversation

```dart
sundayConversations.streamConversation(
  conversationUUID: conversationId
).listen((message) {
  print('Nouveau message reçu : $message');
});
```

## Informations supplémentaires

- [Documentation complète](https://github.com/sunday-team/sunday_conversations)
- [Signaler un problème](https://github.com/sunday-team/sunday_conversations/issues)
- [Contribuer au projet](https://github.com/sunday-team/sunday_conversations/blob/main/CONTRIBUTING.md)

Version actuelle : 0.1.3

Licence : MIT License