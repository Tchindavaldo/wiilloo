import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/home_header.dart';
import '../widgets/category_chips.dart';
import '../widgets/auto_slide_cards.dart';
import '../widgets/design_1_card.dart';
import '../widgets/design_2_card.dart';
import '../widgets/design_3_card.dart';
import '../providers/epreuve_providers.dart';
import '../../data/adapters/epreuve_data_adapter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingTriggered = false; // Flag pour éviter les requêtes multiples
  String _selectedCategory = 'Tous';

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
  void initState() {
    super.initState();

    // Charger les données initiales du backend
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(epreuveNotifierProvider.notifier)
          .loadEpreuves(
            groupBy: 'schoolName',
            itemsPerGroup: 4,
            groupsLimit: 4,
          );
    });

    // Configuration de l'infinite scroll
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Vérifier si on est complètement en bas (100%)
    final isAtBottom = _scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent;
    
    // Vérifier si on est remonté suffisamment (en dessous de 90%)
    final hasScrolledUp = _scrollController.position.pixels < 
        _scrollController.position.maxScrollExtent * 0.9;
    
    if (isAtBottom) {
      final state = ref.read(epreuveNotifierProvider);
      final canLoadMore = ref.read(canLoadMoreProvider);
      
      // Déclencher UNE SEULE FOIS quand on atteint le bas
      if (canLoadMore && !state.isLoadingMore && !_isLoadingTriggered) {
        _isLoadingTriggered = true; // Bloquer jusqu'à ce qu'on remonte
        
        ref.read(epreuveNotifierProvider.notifier).loadMoreEpreuves(
          groupBy: 'schoolName',
          itemsPerGroup: 4,
          groupsLimit: 4,
        );
      }
    } else if (hasScrolledUp) {
      // Réinitialiser le flag seulement si on remonte en dessous de 90%
      _isLoadingTriggered = false;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return _buildHomeContent();
  }

  Widget _buildHomeContent() {
    final state = ref.watch(epreuveNotifierProvider);
    final isInitialLoading = ref.watch(isInitialLoadingProvider);
    final isLoadingMore = ref.watch(isLoadingMoreProvider);

    // Afficher le loader pendant le chargement initial
    if (isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Afficher une erreur si nécessaire
    if (state.error != null && state.groups.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Erreur: ${state.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(epreuveNotifierProvider.notifier).refreshEpreuves();
              },
              child: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }

    // Afficher un message si aucune épreuve disponible
    if (!isInitialLoading && state.groups.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_rounded, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Aucune épreuve disponible',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Revenez plus tard pour découvrir de nouvelles épreuves',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(epreuveNotifierProvider.notifier).refreshEpreuves();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Actualiser'),
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

    // Convertir les groupes du backend en format pour les widgets
    final backendGroups = state.groups;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1E3A8A),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          await ref.read(epreuveNotifierProvider.notifier).refreshEpreuves();
        },
        child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Sticky Header
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: const Color(0xFF1E3A8A),
            elevation: 0,
            toolbarHeight: 120,
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              child: HomeHeader(
                onSearchChanged: (value) {
                  // Handle search
                },
                onNotificationTap: () {
                  // Handle notification tap
                },
                onProfileTap: () {},
              ),
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

          // Auto-sliding cards (Featured) - Toujours avec _appFeatures (ne pas toucher)
          SliverToBoxAdapter(child: AutoSlideCards(items: _appFeatures)),

          // Sections backend - avec designs originaux (ne pas modifier les designs)
          ...backendGroups.asMap().entries.map((entry) {
            final index = entry.key;
            final group = entry.value;
            final epreuvesData = EpreuveDataAdapter.epreuvesToMapList(
              group.epreuves,
            );

            if (epreuvesData.isEmpty) {
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }

            // Utiliser le design original selon l'index - Alternance cyclique
            Widget sectionWidget;
            // Décaler de +1 pour éviter doublon avec AutoSlideCards
            final designIndex = (index + 1) % 4; // Cycle entre 1, 2, 3, 0

            if (designIndex == 0) {
              // Design 0 - Carte simple avec header coloré
              sectionWidget = Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          group.groupKey,
                          style: const TextStyle(
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
                  SizedBox(
                    height: 280,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo is ScrollEndNotification) {
                          final metrics = scrollInfo.metrics;
                          // Trigger ONLY at the EXACT end (100%) and only if not already loading
                          if (metrics.pixels >= metrics.maxScrollExtent &&
                              group.hasMoreHorizontal &&
                              !group.isLoadingHorizontal) {
                            ref.read(epreuveNotifierProvider.notifier).loadMoreHorizontal(
                              groupId: group.id,
                              groupBy: 'schoolName',
                              itemsPerGroup: 4,
                            );
                          }
                        }
                        return false;
                      },
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: epreuvesData.length + (group.hasMoreHorizontal || group.isLoadingHorizontal ? 1 : 0),
                        itemBuilder: (context, idx) {
                          if (idx < epreuvesData.length) {
                            final item = epreuvesData[idx];
                            return Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: GestureDetector(
                                onTap: () => _showEpreuveDetails(item),
                                child: Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.06),
                                        blurRadius: 16,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          color: Colors.grey[200],
                                        ),
                                        child: Stack(
                                          children: [
                                            // Image colorée
                                            ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                color: item['color'] ?? const Color(0xFF3B82F6),
                                                child: Icon(
                                                  Icons.description_rounded,
                                                  size: 50,
                                                  color: Colors.white.withOpacity(0.4),
                                                ),
                                              ),
                                            ),
                                            
                                            // Overlay gradient (COMME DESIGN 2)
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.black.withOpacity(0.5),
                                                    Colors.black.withOpacity(0.2),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item['title'] ?? '',
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF1E293B),
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Spacer(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(Icons.download_rounded,
                                                          size: 14, color: Colors.grey[500]),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        '${item['downloads'] ?? 0}',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey[600],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
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
                          // Loader à la fin
                          if (group.isLoadingHorizontal) {
                            return Container(
                              width: 200,
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (designIndex == 1) {
              // Design 1 - FeaturedEpreuveCard
              sectionWidget = Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          group.groupKey,
                          style: const TextStyle(
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
                  SizedBox(
                    height: 220,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo is ScrollEndNotification) {
                          final metrics = scrollInfo.metrics;
                          // Trigger ONLY at the EXACT end (100%) and only if not already loading
                          if (metrics.pixels >= metrics.maxScrollExtent &&
                              group.hasMoreHorizontal &&
                              !group.isLoadingHorizontal) {
                            ref.read(epreuveNotifierProvider.notifier).loadMoreHorizontal(
                              groupId: group.id,
                              groupBy: 'schoolName',
                              itemsPerGroup: 4,
                            );
                          }
                        }
                        return false;
                      },
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: epreuvesData.length + (group.hasMoreHorizontal || group.isLoadingHorizontal ? 1 : 0),
                        itemBuilder: (context, idx) {
                          if (idx < epreuvesData.length) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Design1Card(
                                item: epreuvesData[idx],
                                onTap: () => _showEpreuveDetails(epreuvesData[idx]),
                              ),
                            );
                          }
                          // Loader à la fin
                          if (group.isLoadingHorizontal) {
                            return Container(
                              width: 180,
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (designIndex == 2) {
              // Design 2 - CompactEpreuveCard
              sectionWidget = Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          group.groupKey,
                          style: const TextStyle(
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
                  SizedBox(
                    height: 160,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo is ScrollEndNotification) {
                          final metrics = scrollInfo.metrics;
                          // Trigger ONLY at the EXACT end (100%) and only if not already loading
                          if (metrics.pixels >= metrics.maxScrollExtent &&
                              group.hasMoreHorizontal &&
                              !group.isLoadingHorizontal) {
                            ref.read(epreuveNotifierProvider.notifier).loadMoreHorizontal(
                              groupId: group.id,
                              groupBy: 'schoolName',
                              itemsPerGroup: 4,
                            );
                          }
                        }
                        return false;
                      },
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: epreuvesData.length + (group.hasMoreHorizontal || group.isLoadingHorizontal ? 1 : 0),
                        itemBuilder: (context, idx) {
                          if (idx < epreuvesData.length) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Design2Card(
                                item: epreuvesData[idx],
                                onTap: () => _showEpreuveDetails(epreuvesData[idx]),
                              ),
                            );
                          }
                          // Loader à la fin
                          if (group.isLoadingHorizontal) {
                            return Container(
                              width: 140,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              // Design 3 - ManualSlideCards
              sectionWidget = Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          group.groupKey,
                          style: const TextStyle(
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
                  Design3Card(
                    items: epreuvesData,
                    onCardTap: (item) => _showEpreuveDetails(item),
                  ),
                ],
              );
            }

            return SliverToBoxAdapter(child: sectionWidget);
          }).toList(),

          // Indicateur de chargement pour l'infinite scroll
          if (isLoadingMore)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),

          // Message de fin si plus de données
          if (!state.hasMore && backendGroups.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'Vous avez atteint la fin de la liste',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),
              ),
            ),

          // Bottom spacing
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
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
                                      'Design 0',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E293B),
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
