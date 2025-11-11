class ConversationModel {
  final String id;
  final String userId;
  final List<MessageModel> messages;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? epreuveId;
  final String? correctionId;

  ConversationModel({
    required this.id,
    required this.userId,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
    this.epreuveId,
    this.correctionId,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      messages: (json['messages'] as List<dynamic>?)
              ?.map((m) => MessageModel.fromJson(m as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      epreuveId: json['epreuveId'],
      correctionId: json['correctionId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'messages': messages.map((m) => m.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'epreuveId': epreuveId,
      'correctionId': correctionId,
    };
  }
}

class MessageModel {
  final String role; // 'user' or 'assistant'
  final String content;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  MessageModel({
    required this.role,
    required this.content,
    required this.timestamp,
    this.metadata,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      role: json['role'] ?? 'user',
      content: json['content'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'metadata': metadata,
    };
  }

  bool get isAi => role == 'assistant';
}
