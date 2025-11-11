import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../data/models/conversation_model.dart';
import '../../data/repositories/ai_chat_repository.dart';
import '../../data/services/ai_chat_api_service.dart';
import '../state/ai_chat_notifier.dart';
import '../state/ai_chat_state.dart';

/// Provider for AI Chat API Service
final aiChatApiServiceProvider = Provider<AiChatApiService>((ref) {
  return AiChatApiService();
});

/// Provider for AI Chat Repository
final aiChatRepositoryProvider = Provider<AiChatRepository>((ref) {
  final apiService = ref.watch(aiChatApiServiceProvider);
  return AiChatRepository(apiService: apiService);
});

/// Provider for AI Chat Notifier
final aiChatNotifierProvider = StateNotifierProvider<AiChatNotifier, AiChatState>((ref) {
  final repository = ref.watch(aiChatRepositoryProvider);
  final currentUser = ref.watch(currentUserProvider);
  final userId = currentUser?.id ?? '';
  
  return AiChatNotifier(repository, userId);
});

/// Provider for conversation history
final conversationHistoryProvider = FutureProvider.family<List<ConversationModel>, String>(
  (ref, userId) async {
    final repository = ref.watch(aiChatRepositoryProvider);
    return await repository.getConversationsByUser(userId);
  },
);

/// Provider to check if sending message
final isSendingProvider = Provider<bool>((ref) {
  final state = ref.watch(aiChatNotifierProvider);
  return state.isSending;
});

/// Provider to check if loading
final isLoadingChatProvider = Provider<bool>((ref) {
  final state = ref.watch(aiChatNotifierProvider);
  return state.isLoading;
});
