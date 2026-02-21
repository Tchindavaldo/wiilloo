import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'Nouvelle épreuve disponible',
      'message': 'Bac Blanc Mathématiques 2024 - Terminale C',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
      'isRead': false,
      'type': 'epreuve',
      'icon': Icons.description_rounded,
      'color': const Color(0xFF3B82F6),
    },
    {
      'id': '2',
      'title': 'Correction IA terminée',
      'message': 'Votre épreuve de physique a été corrigée',
      'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
      'isRead': false,
      'type': 'correction',
      'icon': Icons.auto_awesome_rounded,
      'color': const Color(0xFF10B981),
    },
    {
      'id': '3',
      'title': 'Favori ajouté',
      'message': 'Français - Dissertation ajouté aux favoris',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': true,
      'type': 'favorite',
      'icon': Icons.favorite_rounded,
      'color': Colors.red,
    },
    {
      'id': '4',
      'title': 'Nouveau message',
      'message': 'L\'assistant IA vous a envoyé une réponse',
      'timestamp': DateTime.now().subtract(const Duration(hours: 3)),
      'isRead': true,
      'type': 'message',
      'icon': Icons.chat_rounded,
      'color': const Color(0xFF8B5CF6),
    },
    {
      'id': '5',
      'title': 'Mise à jour disponible',
      'message': 'Nouvelles fonctionnalités ajoutées à WIILLOO',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'isRead': true,
      'type': 'system',
      'icon': Icons.system_update_rounded,
      'color': const Color(0xFFF59E0B),
    },
    {
      'id': '6',
      'title': 'Épreuve recommandée',
      'message': 'Chimie Organique - Basée sur vos intérêts',
      'timestamp': DateTime.now().subtract(const Duration(days: 2)),
      'isRead': true,
      'type': 'recommendation',
      'icon': Icons.trending_up_rounded,
      'color': const Color(0xFFEC4899),
    },
  ];

  String _selectedFilter = 'Toutes';
  final List<String> _filters = ['Toutes', 'Non lues', 'Épreuves', 'Corrections', 'Messages'];

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => !n['isRead']).length;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(unreadCount),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: _notifications.isEmpty ? _buildEmptyState() : _buildNotificationsList(),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar(int unreadCount) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          const Text(
            'Notifications',
            style: TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (unreadCount > 0) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$unreadCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
      actions: [
        if (unreadCount > 0)
          TextButton(
            onPressed: _markAllAsRead,
            child: const Text(
              'Tout lire',
              style: TextStyle(
                color: Color(0xFF3B82F6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        IconButton(
          icon: const Icon(Icons.settings_rounded, color: Color(0xFF64748B)),
          onPressed: _showSettings,
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = filter == _selectedFilter;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              backgroundColor: Colors.white,
              selectedColor: const Color(0xFF3B82F6).withOpacity(0.1),
              checkmarkColor: const Color(0xFF3B82F6),
              labelStyle: TextStyle(
                color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF64748B),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFFE2E8F0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationsList() {
    List<Map<String, dynamic>> filteredNotifications = _getFilteredNotifications();
    
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: filteredNotifications.length,
      itemBuilder: (context, index) {
        final notification = filteredNotifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  List<Map<String, dynamic>> _getFilteredNotifications() {
    switch (_selectedFilter) {
      case 'Non lues':
        return _notifications.where((n) => !n['isRead']).toList();
      case 'Épreuves':
        return _notifications.where((n) => n['type'] == 'epreuve').toList();
      case 'Corrections':
        return _notifications.where((n) => n['type'] == 'correction').toList();
      case 'Messages':
        return _notifications.where((n) => n['type'] == 'message').toList();
      default:
        return _notifications;
    }
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final isRead = notification['isRead'];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : const Color(0xFF3B82F6).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isRead ? const Color(0xFFE2E8F0) : const Color(0xFF3B82F6).withOpacity(0.2),
          width: isRead ? 1 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleNotificationTap(notification),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (notification['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    notification['icon'],
                    color: notification['color'],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification['title'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isRead ? FontWeight.w600 : FontWeight.w700,
                                color: const Color(0xFF1E293B),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (!isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF3B82F6),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification['message'],
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF64748B),
                          fontWeight: isRead ? FontWeight.normal : FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatTimestamp(notification['timestamp']),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isRead)
                  IconButton(
                    icon: const Icon(
                      Icons.mark_email_read_rounded,
                      color: Color(0xFF3B82F6),
                      size: 20,
                    ),
                    onPressed: () => _markAsRead(notification),
                    tooltip: 'Marquer comme lu',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              size: 60,
              color: Color(0xFF3B82F6),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Aucune notification',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedFilter == 'Non lues' 
                ? 'Toutes vos notifications ont été lues'
                : 'Vous n\'avez pas de notifications pour le moment',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: _clearAllNotifications,
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFFEF4444),
      elevation: 2,
      icon: const Icon(Icons.clear_all_rounded),
      label: const Text(
        'Tout effacer',
        style: TextStyle(fontWeight: FontWeight.w600),
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
    } else if (difference.inDays < 7) {
      return 'Il y a ${difference.inDays} j';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    HapticFeedback.lightImpact();
    
    if (!notification['isRead']) {
      _markAsRead(notification);
    }
    
    // Handle navigation based on notification type
    switch (notification['type']) {
      case 'epreuve':
        // Navigate to epreuve details
        break;
      case 'correction':
        // Navigate to correction screen
        break;
      case 'message':
        // Navigate to IA chat
        break;
      default:
        break;
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ouverture de ${notification['title']}...'),
        backgroundColor: const Color(0xFF3B82F6),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _markAsRead(Map<String, dynamic> notification) {
    HapticFeedback.lightImpact();
    setState(() {
      notification['isRead'] = true;
    });
  }

  void _markAllAsRead() {
    HapticFeedback.mediumImpact();
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Toutes les notifications marquées comme lues'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _clearAllNotifications() {
    HapticFeedback.mediumImpact();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Effacer toutes les notifications'),
        content: const Text('Êtes-vous sûr de vouloir effacer toutes les notifications ? Cette action ne peut pas être annulée.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _notifications.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Toutes les notifications ont été effacées'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
            ),
            child: const Text('Effacer'),
          ),
        ],
      ),
    );
  }

  void _showSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Paramètres de notification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Notifications push'),
              subtitle: const Text('Recevoir des notifications sur votre appareil'),
              value: true,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: const Text('Nouvelles épreuves'),
              subtitle: const Text('Être notifié des nouvelles épreuves'),
              value: true,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: const Text('Corrections IA'),
              subtitle: const Text('Être notifié quand une correction est prête'),
              value: true,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: const Text('Messages de l\'IA'),
              subtitle: const Text('Être notifié des nouveaux messages'),
              value: false,
              onChanged: (value) {},
            ),
          ],
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
}
