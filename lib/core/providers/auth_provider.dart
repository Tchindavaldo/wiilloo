import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

// Provider pour le service d'authentification
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Provider pour l'utilisateur actuel
final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, UserModel?>((ref) {
  return CurrentUserNotifier(ref.read(authServiceProvider));
});

// Notifier pour gérer l'état de l'utilisateur actuel
class CurrentUserNotifier extends StateNotifier<UserModel?> {
  final AuthService _authService;

  CurrentUserNotifier(this._authService) : super(null) {
    _loadUser();
  }

  // Charger l'utilisateur depuis le storage au démarrage
  Future<void> _loadUser() async {
    final user = await _authService.getCurrentUser();
    state = user;
  }

  // Connexion avec Google
  Future<bool> signInWithGoogle() async {
    final user = await _authService.signInWithGoogle();
    if (user != null) {
      state = user;
      return true;
    }
    return false;
  }

  // Déconnexion
  Future<void> signOut() async {
    await _authService.signOut();
    state = null;
  }

  // Rafraîchir l'utilisateur
  Future<void> refreshUser() async {
    final user = await _authService.getCurrentUser();
    state = user;
  }

  // Mettre à jour l'utilisateur manuellement
  void updateUser(UserModel? user) {
    state = user;
  }
}

// Provider pour vérifier si l'utilisateur est connecté
final isLoggedInProvider = FutureProvider<bool>((ref) async {
  final authService = ref.read(authServiceProvider);
  return await authService.isLoggedIn();
});
