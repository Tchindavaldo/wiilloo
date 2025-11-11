import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../../../core/config/environment_config.dart';
import '../models/conversation_model.dart';

class AiChatApiService {
  final String baseUrl = EnvironmentConfig.apiBaseUrl;

  /// Send message to AI (with optional file)
  Future<Map<String, dynamic>> sendMessage({
    required String query,
    String? conversationId,
    required String userId,
    File? file,
    String? epreuveId,
    String? correctionId,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/api/gemini/process');
      
      var request = http.MultipartRequest('POST', uri);
      
      // Add text fields
      request.fields['query'] = query;
      request.fields['userId'] = userId;
      
      if (conversationId != null) {
        request.fields['conversationId'] = conversationId;
      }
      if (epreuveId != null) {
        request.fields['epreuveId'] = epreuveId;
      }
      if (correctionId != null) {
        request.fields['correctionId'] = correctionId;
      }

      // Add file if provided
      if (file != null) {
        final mimeType = _getMimeType(file.path);
        request.files.add(
          await http.MultipartFile.fromPath(
            'document',
            file.path,
            contentType: MediaType.parse(mimeType),
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to send message: ${response.body}');
      }
    } catch (e) {
      print('❌ Error sending message: $e');
      rethrow;
    }
  }

  /// Get conversation by ID
  Future<ConversationModel> getConversation(String conversationId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/gemini/conversations/$conversationId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ConversationModel.fromJson(data['data']);
      } else {
        throw Exception('Failed to get conversation: ${response.body}');
      }
    } catch (e) {
      print('❌ Error getting conversation: $e');
      rethrow;
    }
  }

  /// Get conversations by user ID
  Future<List<ConversationModel>> getConversationsByUser(
    String userId, {
    int limit = 20,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/gemini/users/$userId/conversations?limit=$limit'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final conversations = (data['data'] as List)
            .map((c) => ConversationModel.fromJson(c))
            .toList();
        return conversations;
      } else {
        throw Exception('Failed to get conversations: ${response.body}');
      }
    } catch (e) {
      print('❌ Error getting conversations: $e');
      rethrow;
    }
  }

  /// Delete conversation
  Future<void> deleteConversation(String conversationId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/gemini/conversations/$conversationId'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete conversation: ${response.body}');
      }
    } catch (e) {
      print('❌ Error deleting conversation: $e');
      rethrow;
    }
  }

  String _getMimeType(String path) {
    final ext = path.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'txt':
        return 'text/plain';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'application/octet-stream';
    }
  }
}
