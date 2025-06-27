import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _searchQuery = '';

  final List<Map<String, dynamic>> _epreuves = [
    {
      'id': '1',
      'title': 'Mathématiques - Terminale C',
      'subject': 'Mathématiques',
      'level': 'Terminale C',
      'duration': '4h',
      'questions': 25,
      'difficulty': 'Difficile',
      'downloads': '2.3k',
      'rating': 4.8,
      'year': '2024',
      'emoji': '🔢',
      'color': const Color(0xFF3B82F6),
      'isFavorite': false,
      'isDownloaded': false,
    },
    {
      'id': '2',
      'title': 'Physique-Chimie - 1ère D',
      'subject': 'Physique-Chimie',
      'level': '1ère D',
      'duration': '3h',
      'questions': 20,
      'difficulty': 'Moyen',
      'downloads': '1.8k',
      'rating': 4.6,
      'year': '2024',
      'emoji': '⚗️',
      'color': const Color(0xFF10B981),
      'isFavorite': true,
      'isDownloaded': true,
    },
    {
      'id': '3',
      'title': 'Français - 3ème',
      'subject': 'Français',
      'level': '3ème',
      'duration': '2h',
      'questions': 15,
      'difficulty': 'Facile',
      'downloads': '3.1k',
      'rating': 4.9,
      'year': '2024',
      'emoji': '📝',
      'color': const Color(0xFF8B5CF6),
      'isFavorite': false,
      'isDownloaded': false,
    },
    {
      'id': '4',
      'title': 'Anglais - 2nde A',
      'subject': 'Anglais',
      'level': '2nde A',
      'duration': '2h30',
      'questions': 18,
      'difficulty': 'Moyen',
      'downloads': '1.5k',
      'rating': 4.7,
      'year': '2024',
      'emoji': '🇬🇧',
      'color': const Color(0xFFEF4444),
      'isFavorite': false,
      'isDownloaded': true,
    },
  ];

  void _toggleFavorite(String id) {
    setState(() {
      final index = _epreuves.indexWhere((item) => item['id'] == id);
      if (index != -1) {
        _epreuves[index]['isFavorite'] = !_epreuves[index]['isFavorite'];
      }
    });
    HapticFeedback.lightImpact();
  }

  void _toggleDownload(String id) {
    setState(() {
      final index = _epreuves.indexWhere((item) => item['id'] == id);
      if (index != -1) {
        _epreuves[index]['isDownloaded'] = !_epreuves[index]['isDownloaded'];
      }
    });
    HapticFeedback.lightImpact();
  }

  List<Map<String, dynamic>> get _filteredEpreuves {
    if (_searchQuery.isEmpty) return _epreuves;
    return _epreuves.where((epreuve) {
      return epreuve['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
             epreuve['subject'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  List<Map<String, dynamic>> get _myEpreuves {
    return _epreuves.where((epreuve) =>
      epreuve['isFavorite'] == true || epreuve['isDownloaded'] == true
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: _buildCurrentPage(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return _buildMyEpreuvesPage();
      case 2:
        return _buildNotificationsPage();
      case 3:
        return _buildPaymentPage();
      case 4:
        return _buildSettingsPage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(),

          const SizedBox(height: 20),

          // Search Bar
          _buildSearchBar(),

          const SizedBox(height: 20),

          // Stats
          _buildStats(),

          const SizedBox(height: 30),

          // Epreuves List
          const Text(
            'Épreuves disponibles',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),

          const SizedBox(height: 16),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _filteredEpreuves.length,
            itemBuilder: (context, index) {
              return _buildEpreuveCard(_filteredEpreuves[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bonjour ! 👋',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Trouvez vos épreuves',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Rechercher une épreuve...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            '${_epreuves.length}',
            'Épreuves disponibles',
            Icons.menu_book,
            const Color(0xFF3B82F6),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            '${_myEpreuves.length}',
            'Mes épreuves',
            Icons.library_books,
            const Color(0xFF10B981),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEpreuveCard(Map<String, dynamic> epreuve) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: epreuve['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    epreuve['emoji'],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      epreuve['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      '${epreuve['level']} • ${epreuve['year']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _toggleFavorite(epreuve['id']),
                    child: Icon(
                      epreuve['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                      color: epreuve['isFavorite'] ? const Color(0xFFEF4444) : Colors.grey[400],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => _toggleDownload(epreuve['id']),
                    child: Icon(
                      epreuve['isDownloaded'] ? Icons.download_done : Icons.download,
                      color: epreuve['isDownloaded'] ? const Color(0xFF10B981) : Colors.grey[400],
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              _buildInfoChip(Icons.access_time, epreuve['duration']),
              const SizedBox(width: 8),
              _buildInfoChip(Icons.assignment, '${epreuve['questions']} Q'),
              const SizedBox(width: 8),
              _buildInfoChip(Icons.trending_up, epreuve['difficulty']),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber[600], size: 16),
                  const SizedBox(width: 4),
                  Text('${epreuve['rating']}'),
                  const SizedBox(width: 12),
                  Icon(Icons.download, color: Colors.grey[500], size: 16),
                  const SizedBox(width: 4),
                  Text('${epreuve['downloads']}'),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: epreuve['color'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Voir',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyEpreuvesPage() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mes Épreuves',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _buildMyEpreuveTab(
                  'Favoris',
                  Icons.favorite,
                  _epreuves.where((e) => e['isFavorite'] == true).length,
                  const Color(0xFFEF4444),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMyEpreuveTab(
                  'Téléchargées',
                  Icons.download,
                  _epreuves.where((e) => e['isDownloaded'] == true).length,
                  const Color(0xFF10B981),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Expanded(
            child: _myEpreuves.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('📚', style: TextStyle(fontSize: 64)),
                        SizedBox(height: 16),
                        Text(
                          'Aucune épreuve sauvegardée',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Ajoutez des épreuves en favoris ou téléchargez-les',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _myEpreuves.length,
                    itemBuilder: (context, index) {
                      return _buildEpreuveCard(_myEpreuves[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyEpreuveTab(String title, IconData icon, int count, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentPage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.payment, size: 80, color: Color(0xFF667eea)),
          SizedBox(height: 16),
          Text(
            'Paiements',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Gérez vos paiements de scolarité',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Restez informé de toutes les nouveautés',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 24),
          _buildNotificationsList(),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    final notifications = [
      {
        'title': 'Nouvelle épreuve disponible',
        'subtitle': 'Mathématiques - Terminale D vient d\'être ajoutée',
        'time': '2h',
        'icon': Icons.menu_book,
        'color': const Color(0xFF3B82F6),
        'isRead': false,
      },
      {
        'title': 'Épreuve complétée',
        'subtitle': 'Vous avez terminé l\'épreuve de Physique',
        'time': '5h',
        'icon': Icons.check_circle,
        'color': const Color(0xFF10B981),
        'isRead': true,
      },
      {
        'title': 'Rappel de paiement',
        'subtitle': 'Votre abonnement expire dans 3 jours',
        'time': '1j',
        'icon': Icons.payment,
        'color': const Color(0xFFF59E0B),
        'isRead': false,
      },
      {
        'title': 'Mise à jour disponible',
        'subtitle': 'Une nouvelle version de l\'app est disponible',
        'time': '2j',
        'icon': Icons.system_update,
        'color': const Color(0xFF8B5CF6),
        'isRead': true,
      },
    ];

    if (notifications.isEmpty) {
      return const Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            Icon(
              Icons.notifications_none,
              size: 64,
              color: Color(0xFF94A3B8),
            ),
            SizedBox(height: 16),
            Text(
              'Aucune notification',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Vous recevrez ici toutes vos notifications',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: notifications.map((notification) {
        return _buildNotificationItem(
          title: notification['title'] as String,
          subtitle: notification['subtitle'] as String,
          time: notification['time'] as String,
          icon: notification['icon'] as IconData,
          color: notification['color'] as Color,
          isRead: notification['isRead'] as bool,
        );
      }).toList(),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required Color color,
    required bool isRead,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isRead ? const Color(0xFFE2E8F0) : const Color(0xFF667eea).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isRead ? FontWeight.w500 : FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
          ),
        ),
        trailing: Text(
          time,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF94A3B8),
          ),
        ),
        onTap: () {
          // Action lors du tap sur une notification
        },
      ),
    );
  }

  Widget _buildSettingsPage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.settings,
            size: 64,
            color: Color(0xFF94A3B8),
          ),
          SizedBox(height: 16),
          Text(
            'Paramètres',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Configuration de l\'application',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Accueil',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.menu_book_outlined,
                activeIcon: Icons.menu_book,
                label: 'Mes Épreuves',
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.notifications_outlined,
                activeIcon: Icons.notifications,
                label: 'Notifications',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.payment_outlined,
                activeIcon: Icons.payment,
                label: 'Paiements',
                index: 3,
              ),
              _buildNavItem(
                icon: Icons.settings_outlined,
                activeIcon: Icons.settings,
                label: 'Paramètres',
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        HapticFeedback.selectionClick();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
            ? const Color(0xFF667eea).withOpacity(0.1)
            : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive
                ? const Color(0xFF667eea)
                : const Color(0xFF94A3B8),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isActive
                  ? const Color(0xFF667eea)
                  : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
