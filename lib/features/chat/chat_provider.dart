import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memly/features/chat/ai_chat_service.dart';

class ChatMessage {
  final String role;
  final String content;

  ChatMessage({required this.role, required this.content});
}

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier() : super([]);

  Future<void> sendMessage(String userInput) async {
    state = [...state, ChatMessage(role: 'user', content: userInput)];

    try {
      final aiReply = await sendMessageToAI(userInput);
      state = [...state, ChatMessage(role: 'assistant', content: aiReply)];
    } catch (e) {
      state = [
        ...state,
        ChatMessage(role: 'assistant', content: 'Ошибка. Попробуйте еще раз.'),
      ];
    }
  }

  void clearChat() {
    state = [];
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>((
  ref,
) {
  return ChatNotifier();
});
