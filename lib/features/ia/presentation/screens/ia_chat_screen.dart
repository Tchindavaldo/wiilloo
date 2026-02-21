import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class IAChatScreen extends StatefulWidget {
  const IAChatScreen({Key? key}) : super(key: key);

  @override
  State<IAChatScreen> createState() => _IAChatScreenState();
}

class _IAChatScreenState extends State<IAChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _imagePicker = ImagePicker();
  
  List<Map<String, dynamic>> _messages = [
    {
      'id': '1',
      'text': 'Bonjour ! Je suis votre assistant IA WIILLOO. Comment puis-je vous aider ?',
      'sender': 'ia',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
      'type': 'text',
    },
    {
      'id': '2',
      'text': 'Salut ! J\'ai besoin d\'aide pour les intégrales.',
      'sender': 'user',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 4)),
      'type': 'text',
    },
    {
      'id': '3',
      'text': 'Avec plaisir ! Les intégrales permettent de calculer l\'aire sous une courbe. Voici les points essentiels :\n\n1. **Intégrale définie** : ∫[a,b] f(x) dx\n2. **Théorème fondamental** : relie dérivation et intégration\n\nVoulez-vous un exemple concret ?',
      'sender': 'ia',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 3)),
      'type': 'text',
    },
    {
      'id': '4',
      'text': 'Oui, montre-moi un exemple !',
      'sender': 'user',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 2)),
      'type': 'text',
    },
    {
      'id': '5',
      'text': 'Exemple : ∫ x·e^x dx\n\nFormule : ∫ u·dv = uv - ∫ v·du\n\nPosons : u = x → du = dx, dv = e^x dx → v = e^x\n\nDonc : ∫ x·e^x dx = x·e^x - ∫ e^x dx = e^x(x - 1) + C',
      'sender': 'ia',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 1)),
      'type': 'text',
    },
  ];

  bool _isTyping = false;
  List<File> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          if (_selectedImages.isNotEmpty) _buildSelectedImages(),
          _buildMessageInput(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6B21A8), Color(0xFF1E40AF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assistant IA',
                style: TextStyle(
                  color: Color(0xFF1E293B),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'En ligne • Prêt à aider',
                style: TextStyle(
                  color: Color(0xFF10B981),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.history_rounded, color: Color(0xFF64748B)),
          onPressed: _showChatHistory,
        ),
        IconButton(
          icon: const Icon(Icons.more_vert_rounded, color: Color(0xFF64748B)),
          onPressed: _showMoreOptions,
        ),
      ],
    );
  }

  Widget _buildChatHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6B21A8).withOpacity(0.1),
            const Color(0xFF1E40AF).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF6B21A8).withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Capacités de l\'IA',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildCapabilityChip('Mathématiques'),
                        _buildCapabilityChip('Physique'),
                        _buildCapabilityChip('Corrections'),
                        _buildCapabilityChip('PDF'),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.lightbulb_rounded,
                  color: Color(0xFFF59E0B),
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.picture_as_pdf_rounded,
                  color: Color(0xFFEF4444),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '🔥 Correction PDF : Envoyez votre épreuve PDF pour une correction instantanée',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCapabilityChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Color(0xFF64748B),
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _messages.length + (_isTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length && _isTyping) {
          return _buildTypingIndicator();
        }
        
        final message = _messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isUser = message['sender'] == 'user';
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B21A8), Color(0xFF1E40AF)],
                  begin: Alignment.topLeft,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isUser ? const Color(0xFF3B82F6) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message['type'] == 'text')
                        Text(
                          message['text'],
                          style: TextStyle(
                            color: isUser ? Colors.white : const Color(0xFF1E293B),
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      if (message['type'] == 'image' && message['image'] != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                message['image'],
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (message['text'] != null && message['text'].isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                message['text'],
                                style: TextStyle(
                                  color: isUser ? Colors.white : const Color(0xFF1E293B),
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6B21A8), Color(0xFF1E40AF)],
                begin: Alignment.topLeft,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                const SizedBox(width: 4),
                _buildTypingDot(1),
                const SizedBox(width: 4),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: const Color(0xFF64748B),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildSelectedImages() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedImages.length,
        itemBuilder: (context, index) {
          final image = _selectedImages[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedImages.removeAt(index);
                      });
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file_rounded, color: Color(0xFF64748B)),
              onPressed: _showAttachmentOptions,
            ),
            IconButton(
              icon: const Icon(Icons.image_rounded, color: Color(0xFF64748B)),
              onPressed: _pickImage,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Tapez votre message...',
                    hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send_rounded, color: Colors.white),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return 'À l\'instant';
    } else if (difference.inMinutes < 60) {
      return 'Il y a ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'Il y a ${difference.inHours} h';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty && _selectedImages.isEmpty) return;

    HapticFeedback.lightImpact();
    
    // Créer le message utilisateur avec texte et/ou images
    final newMessage = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'text': text,
      'sender': 'user',
      'timestamp': DateTime.now(),
      'type': _selectedImages.isNotEmpty ? 'image' : 'text',
    };

    // Ajouter les images au message si présentes
    if (_selectedImages.isNotEmpty) {
      newMessage['image'] = _selectedImages.first; // Pour l'instant, une seule image
    }

    setState(() {
      _messages.add(newMessage);
      _isTyping = true;
    });

    _messageController.clear();
    
    final images = List<File>.from(_selectedImages);
    setState(() {
      _selectedImages.clear();
    });

    _scrollToBottom();

    // Simuler une réponse IA
    await Future.delayed(const Duration(seconds: 2));
    
    final iaResponse = _generateIAResponse(text);
    final iaMessage = {
      'id': (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      'text': iaResponse,
      'sender': 'ia',
      'timestamp': DateTime.now(),
      'type': 'text',
    };

    setState(() {
      _messages.add(iaMessage);
      _isTyping = false;
    });

    _scrollToBottom();
  }

  String _generateIAResponse(String userMessage) {
    final responses = [
      'Je comprends votre question. Laissez-moi vous aider avec cela. C\'est un sujet intéressant qui mérite une attention particulière.',
      'Excellente question ! Voici une explication détaillée : ce concept est fondamental et s\'applique dans de nombreuses situations.',
      'Je suis là pour vous aider. Analysons cela étape par étape pour que vous puissiez bien comprendre.',
      'C\'est une très bonne observation. Permettez-moi de vous donner une perspective différente sur ce sujet.',
      'Je vois ce que vous voulez dire. Voici comment nous pouvons aborder ce problème de manière efficace.',
    ];
    
    return responses[(DateTime.now().millisecondsSinceEpoch) % responses.length];
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImages.add(File(image.path));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la sélection de l\'image'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Options de pièce jointe',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded, color: Color(0xFF3B82F6)),
              title: const Text('Prendre une photo'),
              onTap: () {
                Navigator.pop(context);
                _pickCameraImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.image_rounded, color: Color(0xFF10B981)),
              title: const Text('Choisir depuis la galerie'),
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file_rounded, color: Color(0xFFF59E0B)),
              title: const Text('Choisir un fichier'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement file picker
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pickCameraImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _selectedImages.add(File(image.path));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la prise de photo'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showChatHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Historique des conversations'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView(
            children: [
              _buildHistoryItem('Aide en mathématiques', 'Il y a 2 heures'),
              _buildHistoryItem('Exercices de physique', 'Hier'),
              _buildHistoryItem('Corrigé dissertation', 'Il y a 3 jours'),
              _buildHistoryItem('Révision chimie', 'Il y a une semaine'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, String time) {
    return ListTile(
      leading: const Icon(Icons.chat_rounded, color: Color(0xFF64748B)),
      title: Text(title),
      subtitle: Text(time),
      onTap: () {
        Navigator.pop(context);
        // TODO: Load specific chat
      },
    );
  }

  void _showMoreOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_rounded, color: Colors.red),
              title: const Text('Effacer la conversation'),
              onTap: () {
                Navigator.pop(context);
                _clearChat();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_rounded, color: Color(0xFF64748B)),
              title: const Text('Paramètres de l\'IA'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Show AI settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_rounded, color: Color(0xFF3B82F6)),
              title: const Text('À propos'),
              onTap: () {
                Navigator.pop(context);
                _showAbout();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  void _clearChat() {
    setState(() {
      _messages = [
        {
          'id': '1',
          'text': 'Conversation effacée. Comment puis-je vous aider maintenant ?',
          'sender': 'ia',
          'timestamp': DateTime.now(),
          'type': 'text',
        }
      ];
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Conversation effacée'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showAbout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('À propos de l\'IA WIILLOO'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Version: 1.0.0',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text('Assistant IA intelligent pour vous aider avec vos études.'),
            SizedBox(height: 16),
            Text(
              'Capacités:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            Text('• Mathématiques et physique'),
            Text('• Corrections d\'épreuves'),
            Text('• Explications personnalisées'),
            Text('• Support multilingue'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
