import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/conversation_model.dart';
import '../../data/repositories/ai_chat_repository.dart';
import 'ai_chat_state.dart';

class AiChatNotifier extends StateNotifier<AiChatState> {
  final AiChatRepository _repository;
  final String userId;

  AiChatNotifier(this._repository, this.userId) : super(AiChatState());

  /// Send a message to AI
  Future<void> sendMessage(String query, {File? file, List<String>? fileNames}) async {
    if (query.trim().isEmpty && file == null) return;

    // Add user message immediately
    final userMessage = MessageModel(
      role: 'user',
      content: query,
      timestamp: DateTime.now(),
      metadata: file != null || (fileNames != null && fileNames.isNotEmpty)
          ? {
              'hasFile': true,
              if (fileNames != null) 'fileNames': fileNames,
            }
          : null,
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isSending: true,
      error: null,
    );

    try {
      final response = await _repository.sendMessage(
        query: query,
        conversationId: state.currentConversationId,
        userId: userId,
        file: file,
      );

      if (response['success'] == true) {
        final data = response['data'];
        final aiResponse = data['response'] as String;
        final conversationId = data['conversationId'] as String?;

        // Add AI response
        final aiMessage = MessageModel(
          role: 'assistant',
          content: aiResponse,
          timestamp: DateTime.parse(data['timestamp'] ?? DateTime.now().toIso8601String()),
        );

        state = state.copyWith(
          currentConversationId: conversationId ?? state.currentConversationId,
          messages: [...state.messages, aiMessage],
          isSending: false,
        );
      } else {
        throw Exception(response['message'] ?? 'Failed to send message');
      }
    } catch (e) {
      print('❌ Error sending message: $e');
      
      // Détecter les erreurs de surcharge
      String errorMessage = e.toString();
      if (errorMessage.contains('503') || 
          errorMessage.contains('Service Unavailable') ||
          errorMessage.contains('overloaded')) {
        errorMessage = 'Le service IA est temporairement surchargé. Veuillez réessayer dans quelques instants.';
      } else if (errorMessage.contains('429') || errorMessage.contains('rate limit')) {
        errorMessage = 'Limite de requêtes atteinte. Veuillez patienter quelques minutes avant de réessayer.';
      } else {
        errorMessage = 'Une erreur est survenue. Veuillez réessayer.';
      }
      
      state = state.copyWith(
        isSending: false,
        error: errorMessage,
      );
    }
  }

  /// Load conversation by ID
  Future<void> loadConversation(String conversationId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final conversation = await _repository.getConversation(conversationId);
      
      state = state.copyWith(
        currentConversationId: conversation.id,
        messages: conversation.messages,
        isLoading: false,
      );
    } catch (e) {
      print('❌ Error loading conversation: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Start a new conversation
  void startNewConversation() {
    state = AiChatState();
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}
