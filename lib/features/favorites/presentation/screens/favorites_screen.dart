import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../epreuve/presentation/screens/epreuve_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> _favoriteEpreuves = [
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
      'description': 'Épreuve complète de mathématiques avec exercices variés couvrant tout le programme de Terminale C.',
      'isFavorite': true,
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
      'description': 'Épreuve de physique-chimie avec expériences pratiques et théorie.',
      'isFavorite': true,
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
      'description': 'Dissertation française sur des thèmes littéraires contemporains.',
      'isFavorite': true,
    },
  ];

  String _selectedCategory = 'Tous';
  final List<String> _categories = ['Tous', 'Math', 'Physique', 'Chimie', 'Français', 'Anglais', 'Histoire', 'SVT'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: _favoriteEpreuves.isEmpty ? _buildEmptyState() : _buildFavoritesList(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'Mes Favoris',
        style: TextStyle(
          color: Color(0xFF1E293B),
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded, color: Color(0xFF64748B)),
          onPressed: _showSearchDialog,
        ),
        IconButton(
          icon: const Icon(Icons.filter_list_rounded, color: Color(0xFF64748B)),
          onPressed: _showFilterDialog,
        ),
      ],
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
              Icons.favorite_border_rounded,
              size: 60,
              color: Color(0xFF3B82F6),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Aucun favori',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ajoutez des épreuves à vos favoris\npour les retrouver facilement ici',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.explore_rounded),
            label: const Text('Explorer les épreuves'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList() {
    return CustomScrollView(
      slivers: [
        // Category chips
        SliverToBoxAdapter(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
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
          ),
        ),
        
        // Stats bar
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('${_favoriteEpreuves.length}', 'Épreuves'),
                _buildStatItem('4.7', 'Note moyenne'),
                _buildStatItem('2.3k', 'Téléchargements'),
              ],
            ),
          ),
        ),

        // Favorites list
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final epreuve = _favoriteEpreuves[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildFavoriteCard(epreuve),
                );
              },
              childCount: _favoriteEpreuves.length,
            ),
          ),
        ),
        
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> epreuve) {
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EpreuveScreen(epreuve: epreuve),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (epreuve['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        epreuve['icon'],
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(width: 16),
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${epreuve['subject']} • ${epreuve['level']}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                        size: 24,
                      ),
                      onPressed: () {
                        _removeFromFavorites(epreuve);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildInfoChip(epreuve['university'], Icons.school_rounded),
                    const SizedBox(width: 8),
                    _buildInfoChip(epreuve['duration'], Icons.access_time_rounded),
                    const SizedBox(width: 8),
                    _buildInfoChip('${epreuve['questions']} questions', Icons.quiz_rounded),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${epreuve['rating']}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (epreuve['hasCorrection'] == true) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified_rounded,
                          size: 16,
                          color: Color(0xFF10B981),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Corrigé disponible',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFF64748B)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _removeFromFavorites(Map<String, dynamic> epreuve) {
    HapticFeedback.lightImpact();
    setState(() {
      _favoriteEpreuves.removeWhere((item) => item['id'] == epreuve['id']);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${epreuve['title']} retiré des favoris'),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Annuler',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _favoriteEpreuves.add(epreuve);
            });
          },
        ),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rechercher'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Rechercher une épreuve...',
            prefixIcon: Icon(Icons.search_rounded),
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Rechercher'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text('Ordre alphabétique'),
              trailing: Icon(Icons.arrow_forward_rounded),
            ),
            const ListTile(
              title: Text('Plus récents'),
              trailing: Icon(Icons.arrow_forward_rounded),
            ),
            const ListTile(
              title: Text('Mieux notés'),
              trailing: Icon(Icons.arrow_forward_rounded),
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
}
