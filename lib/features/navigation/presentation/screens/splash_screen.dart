import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../auth/presentation/screens/auth_screen_v3.dart';
import 'main_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Attendre un peu pour l'effet splash
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Vérifier si l'utilisateur est connecté
    final authService = ref.read(authServiceProvider);
    final isLoggedIn = await authService.isLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      // Charger l'utilisateur dans le provider
      await ref.read(currentUserProvider.notifier).refreshUser();
      
      // Naviguer vers MainScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } else {
      // Naviguer vers AuthScreenV3
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const AuthScreenV3()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo ou nom de l'app
            const Icon(
              Icons.school,
              size: 100,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 24),
            const Text(
              'Wiilloo',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 48),
            // Loader
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
