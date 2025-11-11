import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../widgets/chat_message.dart';
import '../providers/ai_chat_providers.dart';
import '../../data/models/conversation_model.dart';
import '../../../../core/providers/auth_provider.dart';

class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<File> _selectedFiles = [];
  bool _showHistory = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'jpg', 'jpeg', 'png'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFiles.addAll(
            result.files
                .where((file) => file.path != null)
                .map((file) => File(file.path!))
                .toList(),
          );
        });
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty && _selectedFiles.isEmpty) return;

    _messageController.clear();
    final files = List<File>.from(_selectedFiles);
    setState(() {
      _selectedFiles.clear();
    });

    // Pour l'instant, envoyer seulement le premier fichier (backend supporte 1 fichier)
    // TODO: Modifier le backend pour supporter plusieurs fichiers
    await ref.read(aiChatNotifierProvider.notifier).sendMessage(
      message.isEmpty ? 'Analyser ces fichiers' : message,
      file: files.isNotEmpty ? files.first : null,
      fileNames: files.map((f) => f.path.split('/').last).toList(),
    );

    // Scroll to bottom after sending
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  void _toggleHistory() {
    setState(() {
      _showHistory = !_showHistory;
    });
  }

  void _startNewConversation() {
    ref.read(aiChatNotifierProvider.notifier).startNewConversation();
  }

  Widget _buildHistorySheet() {
    final currentUser = ref.watch(currentUserProvider);
    if (currentUser == null) return const SizedBox();

    final conversationsAsync = ref.watch(conversationHistoryProvider(currentUser.id));

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Historique des conversations',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: conversationsAsync.when(
                data: (conversations) {
                  if (conversations.isEmpty) {
                    return const Center(
                      child: Text('Aucune conversation'),
                    );
                  }
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final conversation = conversations[index];
                      final lastMessage = conversation.messages.isNotEmpty
                          ? conversation.messages.last.content
                          : 'Nouvelle conversation';
                      return ListTile(
                        leading: const Icon(Icons.chat_bubble_outline),
                        title: Text(
                          lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${conversation.messages.length} messages',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          ref.read(aiChatNotifierProvider.notifier)
                              .loadConversation(conversation.id);
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text('Erreur: $error'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(aiChatNotifierProvider);
    final messages = state.messages;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Main Chat Area
            Column(
              children: [
            // Sticky Header
            Container(
              color: Colors.white,
              child: SafeArea(
                bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Wilia',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            _showHistory ? Icons.close : Icons.history,
                            size: 24,
                          ),
                          color: _showHistory
                              ? const Color(0xFF1173d4)
                              : const Color(0xFF6B7280),
                          onPressed: _toggleHistory,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.edit, size: 24),
                          color: const Color(0xFF1173d4),
                          onPressed: _startNewConversation,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Chat Messages
          Expanded(
            child: Column(
              children: [
                // Error message
                if (state.error != null)
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFEF4444)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Color(0xFFEF4444)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            state.error!,
                            style: const TextStyle(
                              color: Color(0xFFEF4444),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          color: const Color(0xFFEF4444),
                          onPressed: () {
                            ref.read(aiChatNotifierProvider.notifier).clearError();
                          },
                        ),
                      ],
                    ),
                  ),
                // Messages
                Expanded(
                  child: messages.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.auto_awesome_rounded,
                                  size: 64, color: Colors.grey[300]),
                              const SizedBox(height: 16),
                              Text(
                                'Demandez à Wilia',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Posez vos questions ou envoyez un document',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length + (state.isSending ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < messages.length) {
                        final message = messages[index];
                        final fileNames = message.metadata?['fileNames'] as List<dynamic>?;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: ChatMessage(
                            isAi: message.isAi,
                            message: message.content,
                            attachedFiles: fileNames?.cast<String>(),
                          ),
                        );
                      } else {
                        // Loading indicator
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 24),
                          child: Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 12),
                              Text('Wilia réfléchit...'),
                            ],
                          ),
                        );
                      }
                      },
                    ),
                ),
              ],
            ),
          ),
          
          // Input Area
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Files preview chips
                  if (_selectedFiles.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      constraints: const BoxConstraints(maxHeight: 100),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _selectedFiles.asMap().entries.map((entry) {
                            final index = entry.key;
                            final file = entry.value;
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFF1173d4).withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.insert_drive_file,
                                    size: 16,
                                    color: Color(0xFF1173d4),
                                  ),
                                  const SizedBox(width: 8),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 150),
                                    child: Text(
                                      file.path.split('/').last,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF1173d4),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () => _removeFile(index),
                                    child: const Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Color(0xFF1173d4),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  // Input field
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(44),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            _selectedFiles.isNotEmpty
                                ? Icons.attach_file
                                : Icons.upload_file,
                            color: _selectedFiles.isNotEmpty
                                ? const Color(0xFF1173d4)
                                : const Color(0xFF6B7280),
                          ),
                          onPressed: _pickFile,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: const InputDecoration(
                              hintText: 'Ask Wilia...',
                              hintStyle: TextStyle(color: Color(0xFF6B7280)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            ),
                            maxLines: null,
                            onSubmitted: (_) => _sendMessage(),
                          ),
                        ),
                        GestureDetector(
                          onTap: state.isSending ? null : _sendMessage,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: state.isSending
                                  ? const Color(0xFF9CA3AF)
                                  : const Color(0xFF1173d4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: state.isSending
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : const Icon(Icons.arrow_upward, color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
              ],
            ),
            // History Sidebar Overlay
            if (_showHistory)
              Stack(
                children: [
                  // Backdrop - close on tap
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: _toggleHistory,
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
                  // Sidebar
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    child: Material(
                      elevation: 8,
                      child: SafeArea(
                        child: Container(
                          width: 280,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(2, 0),
                              ),
                            ],
                          ),
                          child: _buildHistorySidebar(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorySidebar() {
    final currentUser = ref.watch(currentUserProvider);
    if (currentUser == null) return const SizedBox();

    final conversationsAsync = ref.watch(conversationHistoryProvider(currentUser.id));

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
          ),
          child: Row(
            children: [
              const Icon(Icons.history, size: 20, color: Color(0xFF1173d4)),
              const SizedBox(width: 8),
              const Text(
                'Historique',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
        ),
        // Liste des conversations
        Expanded(
          child: conversationsAsync.when(
            data: (conversations) {
              if (conversations.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline,
                          size: 48, color: Colors.grey[300]),
                      const SizedBox(height: 12),
                      Text(
                        'Aucune conversation',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  final conversation = conversations[index];
                  final lastMessage = conversation.messages.isNotEmpty
                      ? conversation.messages.last.content
                      : 'Nouvelle conversation';
                  final isActive = ref.watch(aiChatNotifierProvider)
                      .currentConversationId == conversation.id;
                  
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFFEFF6FF)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      dense: true,
                      leading: Icon(
                        Icons.chat_bubble_outline,
                        size: 20,
                        color: isActive
                            ? const Color(0xFF1173d4)
                            : Colors.grey[400],
                      ),
                      title: Text(
                        lastMessage,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                          color: isActive
                              ? const Color(0xFF1173d4)
                              : const Color(0xFF1F2937),
                        ),
                      ),
                      subtitle: Text(
                        '${conversation.messages.length} messages',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[500],
                        ),
                      ),
                      onTap: () {
                        ref.read(aiChatNotifierProvider.notifier)
                            .loadConversation(conversation.id);
                      },
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text(
                'Erreur: $error',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
