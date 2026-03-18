import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../services/ai/ai_service.dart';
import '../../domain/models/message.dart';

class ChatState {
  final List<Message> messages;
  final bool isTyping;

  ChatState({required this.messages, this.isTyping = false});

  ChatState copyWith({List<Message>? messages, bool? isTyping}) {
    return ChatState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  final AIService _aiService = AIService();

  ChatNotifier() : super(ChatState(messages: [
    Message(
      id: '1',
      content: 'Hello! I am your AI assistant. How can I help you today?',
      role: MessageRole.assistant,
      timestamp: DateTime.now(),
    ),
  ]));

  void sendMessage(String content) async {
    final userMessage = Message(
      id: DateTime.now().toString(),
      content: content,
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isTyping: true,
    );

    final response = await _aiService.getResponse(content);

    final aiResponse = Message(
      id: DateTime.now().toString(),
      content: response,
      role: MessageRole.assistant,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, aiResponse],
      isTyping: false,
    );
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier();
});
