import '../../data/models/conversation_model.dart';

class AiChatState {
  final String? currentConversationId;
  final List<MessageModel> messages;
  final bool isLoading;
  final bool isSending;
  final String? error;

  AiChatState({
    this.currentConversationId,
    this.messages = const [],
    this.isLoading = false,
    this.isSending = false,
    this.error,
  });

  AiChatState copyWith({
    String? currentConversationId,
    List<MessageModel>? messages,
    bool? isLoading,
    bool? isSending,
    String? error,
  }) {
    return AiChatState(
      currentConversationId: currentConversationId ?? this.currentConversationId,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      error: error,
    );
  }
}
