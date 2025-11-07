import 'package:flutter/material.dart';
import '../../../home/presentation/screens/home_page.dart';
import '../../../proofs/presentation/screens/proofs_screen.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';
import '../../../ai_chat/presentation/screens/ai_chat_screen.dart';
import '../../../settings/presentation/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Liste des pages
  final List<Widget> _pages = [
    const HomePage(),
    const ProofsScreen(),
    const NotificationsScreen(),
    const AiChatScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavBar(),
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
                icon: Icons.description_rounded,
                label: 'Proofs',
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
    final isActive = _currentIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
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
}
