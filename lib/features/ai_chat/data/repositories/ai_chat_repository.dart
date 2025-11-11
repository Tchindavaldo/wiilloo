import 'dart:io';
import '../models/conversation_model.dart';
import '../services/ai_chat_api_service.dart';

class AiChatRepository {
  final AiChatApiService _apiService;

  AiChatRepository({required AiChatApiService apiService})
      : _apiService = apiService;

  Future<Map<String, dynamic>> sendMessage({
    required String query,
    String? conversationId,
    required String userId,
    File? file,
    String? epreuveId,
    String? correctionId,
  }) async {
    return await _apiService.sendMessage(
      query: query,
      conversationId: conversationId,
      userId: userId,
      file: file,
      epreuveId: epreuveId,
      correctionId: correctionId,
    );
  }

  Future<ConversationModel> getConversation(String conversationId) async {
    return await _apiService.getConversation(conversationId);
  }

  Future<List<ConversationModel>> getConversationsByUser(
    String userId, {
    int limit = 20,
  }) async {
    return await _apiService.getConversationsByUser(userId, limit: limit);
  }

  Future<void> deleteConversation(String conversationId) async {
    return await _apiService.deleteConversation(conversationId);
  }
}
