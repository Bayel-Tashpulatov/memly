enum MessageSender { user, ai }

class ChatMessage {
  final String text;
  final MessageSender sender;

  ChatMessage({
    required this.text,
    required this.sender,
  });
}
