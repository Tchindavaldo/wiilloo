import 'package:flutter/material.dart';
import '../widgets/home_header.dart';
import '../widgets/category_chips.dart';
import '../widgets/auto_slide_cards.dart';
import '../widgets/manual_slide_cards.dart';
import '../widgets/epreuve_card_section.dart';
import '../widgets/featured_epreuve_card.dart';
import '../widgets/compact_epreuve_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  String _selectedCategory = 'Tous';
  String _userName = 'Utilisateur';
  String _userPhone = '+237 6X XX XX XX';

  final List<String> _categories = [
    'Tous',
    'Math',
    'Physique',
    'Chimie',
    'Français',
    'Anglais',
    'Histoire',
    'SVT',
  ];

  // Fonctionnalités de WIILLOO pour auto-slide
  final List<Map<String, dynamic>> _appFeatures = [
    {
      'id': '1',
      'title': 'Des milliers d\'épreuves sur une seule plateforme',
      'badge': 'Bibliothèque',
      'description':
          'Accédez à une vaste collection d\'épreuves et corrigés de toutes les matières pour tous les niveaux',
      'badgeIcon': Icons.library_books_rounded,
      'featureIcon': Icons.school_rounded,
      'color': const Color(0xFF3B82F6),
    },
    {
      'id': '2',
      'title': 'Corrigé par des professeurs expérimentés',
      'badge': 'Qualité',
      'description':
          'Bénéficiez de corrections détaillées et précises réalisées par des enseignants professionnels',
      'badgeIcon': Icons.verified_rounded,
      'featureIcon': Icons.supervisor_account_rounded,
      'color': const Color(0xFF10B981),
    },
    {
      'id': '3',
      'title': 'Correction instantanée avec IA',
      'badge': 'IA Avancée',
      'description':
          'Obtenez des corrections immédiates et personnalisées grâce à notre intelligence artificielle',
      'badgeIcon': Icons.auto_awesome_rounded,
      'featureIcon': Icons.psychology_rounded,
      'color': const Color(0xFF8B5CF6),
    },
    {
      'id': '4',
      'title': 'Préparez vos examens et concours avec WIILLOO',
      'badge': 'Succès',
      'description':
          'Entraînez-vous efficacement et maximisez vos chances de réussite aux examens',
      'badgeIcon': Icons.emoji_events_rounded,
      'featureIcon': Icons.rocket_launch_rounded,
      'color': const Color(0xFFEC4899),
    },
  ];

  // Sample data - Épreuves populaires
  final List<Map<String, dynamic>> _popularEpreuves = [
    {
      'id': '1',
      'title': 'Bac Blanc Mathématiques',
      'subject': 'Mathématiques',
      'level': 'Terminale C',
      'duration': '4h',
      'questions': 25,
      'difficulty': 'Difficile',
      'downloads': 2300,
      'rating': 4.8,
      'year': '2024',
      'university': 'UDM',
      'class': 'MED 1',
      'period': 'Semestre 1',
      'hasCorrection': true,
      'color': const Color(0xFF3B82F6),
      'icon': '📐',
    },
    {
      'id': '2',
      'title': 'Physique-Chimie Terminale',
      'subject': 'Physique-Chimie',
      'level': 'Terminale D',
      'duration': '3h',
      'questions': 20,
      'difficulty': 'Moyen',
      'downloads': 1800,
      'rating': 4.6,
      'year': '2024',
      'university': 'UDS',
      'class': 'INFO 2',
      'period': 'Semestre 2',
      'hasCorrection': true,
      'color': const Color(0xFF10B981),
      'icon': '⚗️',
    },
    {
      'id': '3',
      'title': 'Français - Dissertation',
      'subject': 'Français',
      'level': '1ère',
      'duration': '2h',
      'questions': 15,
      'difficulty': 'Facile',
      'downloads': 3100,
      'rating': 4.9,
      'year': '2025',
      'university': 'UDY',
      'class': 'CM2',
      'period': 'Séquence 2',
      'hasCorrection': true,
      'color': const Color(0xFF8B5CF6),
      'icon': '📝',
    },
  ];

  // Sample data - Nouvelles épreuves
  final List<Map<String, dynamic>> _newEpreuves = [
    {
      'id': '4',
      'title': 'Anglais - Comprehension',
      'subject': 'Anglais',
      'level': '2nde',
      'duration': '2h30',
      'questions': 18,
      'difficulty': 'Moyen',
      'downloads': '856',
      'rating': 4.7,
      'year': '2024',
      'hasCorrection': true,
      'color': const Color(0xFFEF4444),
      'icon': '🇬🇧',
    },
    {
      'id': '5',
      'title': 'SVT - Système Nerveux',
      'subject': 'SVT',
      'level': '3ème',
      'duration': '1h30',
      'questions': 12,
      'difficulty': 'Facile',
      'downloads': '642',
      'rating': 4.5,
      'year': '2024',
      'hasCorrection': false,
      'color': const Color(0xFF06B6D4),
      'icon': '🧬',
    },
    {
      'id': '6',
      'title': 'Histoire - 2ème Guerre',
      'subject': 'Histoire',
      'level': '1ère',
      'duration': '2h',
      'questions': 10,
      'difficulty': 'Moyen',
      'downloads': '1.2k',
      'rating': 4.6,
      'year': '2024',
      'hasCorrection': true,
      'color': const Color(0xFFF59E0B),
      'icon': '🏛️',
    },
  ];

  // Sample data - Épreuves recommandées (plus compactes)
  final List<Map<String, dynamic>> _recommendedEpreuves = [
    {
      'id': '7',
      'title': 'Chimie Organique',
      'subject': 'Chimie',
      'level': 'Terminale',
      'questions': 15,
      'rating': 4.7,
      'year': '2025',
      'university': 'UDM',
      'class': 'Terminale',
      'period': 'Semestre 1',
      'downloads': 654,
      'hasCorrection': true,
      'color': const Color(0xFFEC4899),
      'icon': '🧪',
    },
    {
      'id': '8',
      'title': 'Géométrie Analytique',
      'subject': 'Mathématiques',
      'level': '1ère',
      'questions': 20,
      'rating': 4.8,
      'year': '2025',
      'university': 'UDS',
      'class': '1ère',
      'period': 'Séquence 1',
      'downloads': 892,
      'hasCorrection': true,
      'color': const Color(0xFF6366F1),
      'icon': '📊',
    },
    {
      'id': '9',
      'title': 'Littérature Africaine',
      'subject': 'Français',
      'level': 'Terminale',
      'questions': 8,
      'rating': 4.5,
      'year': '2025',
      'university': 'UDY',
      'class': 'Terminale',
      'period': 'Séquence 1',
      'downloads': 1247,
      'hasCorrection': false,
      'color': const Color(0xFF14B8A6),
      'icon': '📚',
    },
    {
      'id': '10',
      'title': 'Électricité',
      'subject': 'Physique',
      'level': '3ème',
      'questions': 12,
      'rating': 4.6,
      'hasCorrection': true,
      'color': const Color(0xFFF97316),
      'icon': '⚡',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  void _openEditProfile() {
    final cs = Theme.of(context).colorScheme;
    final primary = const Color(0xFF3B82F6);
    final nameController = TextEditingController(text: _userName);
    final phoneController = TextEditingController(text: _userPhone);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Modifier le profil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: primary,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  prefixIcon: const Icon(Icons.person_rounded),
                  filled: true,
                  fillColor: primary.withOpacity(0.06),
                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: primary, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Numéro de téléphone',
                  prefixIcon: const Icon(Icons.phone_rounded),
                  filled: true,
                  fillColor: primary.withOpacity(0.06),
                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: primary, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primary,
                        side: BorderSide(color: primary),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Annuler'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _userName = nameController.text.trim().isEmpty ? _userName : nameController.text.trim();
                          _userPhone = phoneController.text.trim().isEmpty ? _userPhone : phoneController.text.trim();
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Enregistrer'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmLogout() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Déconnexion'),
          content: const Text('Voulez-vous vraiment vous déconnecter ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Annuler'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Se déconnecter'),
            ),
          ],
        );
      },
    );
    if (result == true) {
      // Intégrer votre logique de déconnexion ici si nécessaire
    }
  }

  Widget _buildBody() {
    if (_currentNavIndex == 0) {
      return _buildHomeContent();
    } else if (_currentNavIndex == 1) {
      return _buildFavoritesContent();
    } else if (_currentNavIndex == 2) {
      return _buildNotificationsContent();
    } else if (_currentNavIndex == 3) {
      return _buildIAContent();
    } else if (_currentNavIndex == 4) {
      return _buildProfileContent();
    }
    return _buildHomeContent();
  }

  Widget _buildHomeContent() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Header avec recherche, notifications et avatar
        SliverToBoxAdapter(
          child: HomeHeader(
            onSearchChanged: (value) {
              // Handle search
            },
            onNotificationTap: () {
              // Handle notification tap
            },
            onProfileTap: () {
              setState(() {
                _currentNavIndex = 4;
              });
            },
          ),
        ),

        // Category chips
        SliverToBoxAdapter(
          child: CategoryChips(
            categories: _categories,
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          ),
        ),

        // Auto-sliding cards (Featured)
        SliverToBoxAdapter(child: AutoSlideCards(items: _appFeatures)),

        // Section title - Épreuves populaires
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Unoversite des Montagnes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Voir tout',
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Horizontal scrolling cards - Popular (Style 1)
        SliverToBoxAdapter(
          child: EpreuveCardSection(
            items: _popularEpreuves,
            onCardTap: (item) {
              // Handle card tap
              _showEpreuveDetails(item);
            },
          ),
        ),

        // Section title - Nouvelles épreuves
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Unoversite de Dschang',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Voir tout',
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Horizontal scrolling cards - New (Style 2 - Featured style)
        SliverToBoxAdapter(
          child: SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _newEpreuves.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: FeaturedEpreuveCard(
                    item: _newEpreuves[index],
                    onTap: () => _showEpreuveDetails(_newEpreuves[index]),
                  ),
                );
              },
            ),
          ),
        ),

        // Section title - Recommandations
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Unoversite de Yde 1',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Voir tout',
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Horizontal scrolling cards - Recommended (Style 3 - Compact)
        SliverToBoxAdapter(
          child: SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _recommendedEpreuves.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: CompactEpreuveCard(
                    item: _recommendedEpreuves[index],
                    onTap: () =>
                        _showEpreuveDetails(_recommendedEpreuves[index]),
                  ),
                );
              },
            ),
          ),
        ),

        // Section title - Explorez plus
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'College Jean Tabi',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Voir tout',
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Manual slide carousel - identique au premier mais manuel
        SliverToBoxAdapter(
          child: ManualSlideCards(
            items: _popularEpreuves,
            onCardTap: (item) => _showEpreuveDetails(item),
          ),
        ),

        // Bottom spacing
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }

  Widget _buildFavoritesContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_rounded, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Mes Favoris',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vos épreuves favorites apparaîtront ici',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_rounded, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Notifications',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Aucune notification pour le moment',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildIAContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [const Color(0xFF6B21A8), const Color(0xFF1E40AF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Assistant IA',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Votre assistant intelligent pour les épreuves',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent() {
    final cs = Theme.of(context).colorScheme;
    final primary = const Color(0xFF3B82F6);
    final onSurfaceSubtle = Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7);
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
                border: Border.all(color: primary.withOpacity(0.12)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [primary, primary.withOpacity(0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(Icons.person, size: 38, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: cs.onSurface,
                            letterSpacing: -0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _userPhone,
                          style: TextStyle(fontSize: 13, color: onSurfaceSubtle),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.edit_rounded, color: primary),
                    onPressed: _openEditProfile,
                    tooltip: 'Modifier',
                  )
                ],
              ),
            ),
  const SizedBox(height: 30),

            // Settings list
            _ProfileSection(
              
              children: [
                _ProfileTile(
                  icon: Icons.translate_rounded,
                  title: 'Abonnement',
                  subtitle: 'Consultez votre abonnement',
                  onTap: () {},
                ),
                  _ProfileTile(
                  icon: Icons.history_rounded,
                  title: 'Historique',
                  subtitle: 'Consultez votre historique de paiement',
                  onTap: () {},
                ),
                
                _ProfileTile(
                  icon: Icons.translate_rounded,
                  title: 'Langue',
                  subtitle: 'Français',
                  onTap: () {},
                ),
                _ProfileTile(
                  icon: Icons.dark_mode_rounded,
                  title: 'Apparence',
                  subtitle: 'Système',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 12),

   const SizedBox(width: 22),
            _ProfileSection(
             
              children: [
                _ProfileTile(
                  icon: Icons.help_center_rounded,
                  title: " A propos de l'application",
                  onTap: () {},
                ),
                _ProfileTile(
                  icon: Icons.mail_rounded,
                  title: 'Aide & FAQ',
                  onTap: () {},
                ),
                _ProfileTile(
                  icon: Icons.logout_rounded,
                  title: 'Se déconnecter',
                  onTap: _confirmLogout,
                  color: Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: 'Accueil',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.favorite_rounded,
                label: 'Favoris',
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.notifications_rounded,
                label: 'Alertes',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.auto_awesome_rounded,
                label: 'IA',
                index: 3,
              ),
              _buildNavItem(
                icon: Icons.person_rounded,
                label: 'Profil',
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
    required String label,
    required int index,
  }) {
    final isActive = _currentNavIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _currentNavIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF3B82F6).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF3B82F6) : Colors.grey[400],
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? const Color(0xFF3B82F6) : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEpreuveDetails(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.7,
        maxChildSize: 0.75,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFF0F172A), const Color(0xFF1E293B)],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag handle élégant
              Container(
                width: 48,
                height: 5,
                margin: const EdgeInsets.only(top: 16, bottom: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      item['color'] ?? const Color(0xFF3B82F6),
                      (item['color'] ?? const Color(0xFF3B82F6)).withOpacity(
                        0.5,
                      ),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre avec gradient
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [Colors.white, Colors.white.withOpacity(0.9)],
                        ).createShader(bounds),
                        child: Text(
                          item['title'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.3,
                            letterSpacing: -0.5,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Ligne de badges élégants
                      Row(
                        children: [
                          _buildGlassBadge(
                            item['university'] ?? 'UDM',
                            Icons.school_rounded,
                          ),
                          const SizedBox(width: 8),
                          _buildGlassBadge(
                            item['class'] ?? 'MED 1',
                            Icons.class_rounded,
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  item['color'] ?? const Color(0xFF3B82F6),
                                  (item['color'] ?? const Color(0xFF3B82F6))
                                      .withOpacity(0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      (item['color'] ?? const Color(0xFF3B82F6))
                                          .withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              item['year'] ?? '2024',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Stats avec design glassmorphism
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildGlassStat(
                              Icons.download_rounded,
                              '${item['downloads'] ?? 0}',
                              const Color(0xFF3B82F6),
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: Colors.white.withOpacity(0.1),
                            ),
                            _buildGlassStat(
                              Icons.star_rounded,
                              '${item['rating'] ?? 4.5}',
                              const Color(0xFFFBBF24),
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: Colors.white.withOpacity(0.1),
                            ),
                            _buildGlassStat(
                              Icons.access_time_rounded,
                              item['duration'] ?? '4h',
                              const Color(0xFF10B981),
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: Colors.white.withOpacity(0.1),
                            ),
                            _buildGlassStat(
                              Icons.quiz_rounded,
                              '${item['questions'] ?? 25}',
                              const Color(0xFF8B5CF6),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Description
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.08),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.description_outlined,
                                  size: 16,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['description'] ??
                                  'Épreuve complète avec exercices variés et corrigé détaillé. Idéale pour préparer vos examens et consolider vos connaissances.',
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.5,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // Correcteur si disponible
                      if (item['hasCorrection'] == true) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF10B981).withOpacity(0.15),
                                const Color(0xFF10B981).withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF10B981).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF10B981,
                                  ).withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.verified_rounded,
                                  size: 18,
                                  color: Color(0xFF10B981),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Corrigé disponible',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF10B981),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Par ${item['corrector'] ?? 'Prof. Jean Dupont'}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),

                      // Boutons de téléchargement
                      Text(
                        'Télécharger l\'épreuve',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDownloadButton(
                              'PDF',
                              Icons.picture_as_pdf_rounded,
                              const Color(0xFFEF4444),
                              () {
                                Navigator.pop(context);
                                // TODO: Télécharger PDF
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildDownloadButton(
                              'Word',
                              Icons.article_rounded,
                              const Color(0xFF2563EB),
                              () {
                                Navigator.pop(context);
                                // TODO: Télécharger Word
                              },
                            ),
                          ),
                        ],
                      ),

                      if (item['hasCorrection'] == true) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Télécharger le corrigé',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDownloadButton(
                                'PDF',
                                Icons.picture_as_pdf_rounded,
                                const Color(0xFF10B981),
                                () {
                                  Navigator.pop(context);
                                  // TODO: Télécharger corrigé PDF
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDownloadButton(
                                'Word',
                                Icons.article_rounded,
                                const Color(0xFF10B981),
                                () {
                                  Navigator.pop(context);
                                  // TODO: Télécharger corrigé Word
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlassBadge(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white.withOpacity(0.9)),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassStat(IconData icon, String value, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDownloadButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ProfileActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const _ProfileSection({
    this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final primary = const Color(0xFF3B82F6);
    final subtle = Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              title!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: subtle,
                letterSpacing: 0.2,
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: primary.withOpacity(0.12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color? color;

  const _ProfileTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final primary = const Color(0xFF3B82F6);
    final accent = color ?? primary;
    final onSurface = Theme.of(context).textTheme.bodyLarge?.color;
    final onSurfaceSubtle = Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: accent, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: color ?? onSurface,
                      letterSpacing: 0.1,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: TextStyle(fontSize: 12, color: onSurfaceSubtle),
                    ),
                  ]
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right_rounded, color: accent.withOpacity(0.8), size: 20),
          ],
        ),
      ),
    );
  }
}
