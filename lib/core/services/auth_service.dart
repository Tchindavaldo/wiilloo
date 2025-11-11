import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/environment_config.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  static const String _userKey = 'current_user';
  static const String _isLoggedInKey = 'is_logged_in';

  // Stream pour écouter les changements d'état d'authentification
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Utilisateur Firebase actuel
  User? get currentFirebaseUser => _firebaseAuth.currentUser;

  /// Connexion avec Google
  Future<UserModel?> signInWithGoogle() async {
    try {
      print('🔐 Début de la connexion Google...');

      // 1. Connexion Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        print('❌ Connexion Google annulée par l\'utilisateur');
        return null;
      }

      print('✅ Google Sign-In réussi: ${googleUser.email}');

      // 2. Obtenir les credentials Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 3. Créer les credentials Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Se connecter à Firebase
      final UserCredential userCredential = 
          await _firebaseAuth.signInWithCredential(credential);
      
      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        print('❌ Échec de la connexion Firebase');
        return null;
      }

      print('✅ Firebase Auth réussi: ${firebaseUser.uid}');

      // 5. Envoyer les données au backend pour créer/mettre à jour l'utilisateur
      final userModel = await _syncUserWithBackend(firebaseUser);

      if (userModel != null) {
        // 6. Sauvegarder dans le storage local
        await _saveUserToStorage(userModel);
        print('✅ Utilisateur sauvegardé dans le storage local');
      }

      return userModel;

    } catch (e) {
      print('❌ Erreur lors de la connexion Google: $e');
      return null;
    }
  }

  /// Synchroniser l'utilisateur avec le backend
  Future<UserModel?> _syncUserWithBackend(User firebaseUser) async {
    try {
      final url = Uri.parse('${EnvironmentConfig.apiBaseUrl}/api/users/auth');
      
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'uid': firebaseUser.uid,
          'email': firebaseUser.email,
          'displayName': firebaseUser.displayName,
          'photoURL': firebaseUser.photoURL,
          'phoneNumber': firebaseUser.phoneNumber,
        }),
      );

      print('📡 Réponse backend: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          print('✅ Utilisateur synchronisé avec le backend');
          return UserModel.fromJson(data['user']);
        }
      }

      print('❌ Échec de la synchronisation backend: ${response.body}');
      return null;

    } catch (e) {
      print('❌ Erreur sync backend: $e');
      return null;
    }
  }

  /// Sauvegarder l'utilisateur dans le storage local
  Future<void> _saveUserToStorage(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
    await prefs.setBool(_isLoggedInKey, true);
  }

  /// Récupérer l'utilisateur depuis le storage local
  Future<UserModel?> getUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      
      if (userJson != null) {
        return UserModel.fromJson(jsonDecode(userJson));
      }
      return null;
    } catch (e) {
      print('❌ Erreur récupération user storage: $e');
      return null;
    }
  }

  /// Vérifier si l'utilisateur est connecté
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// Déconnexion
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
      await prefs.setBool(_isLoggedInKey, false);
      
      print('✅ Déconnexion réussie');
    } catch (e) {
      print('❌ Erreur lors de la déconnexion: $e');
    }
  }

  /// Récupérer l'utilisateur actuel (storage ou Firebase)
  Future<UserModel?> getCurrentUser() async {
    // D'abord essayer depuis le storage
    UserModel? user = await getUserFromStorage();
    
    if (user != null) {
      return user;
    }

    // Sinon, vérifier Firebase
    final firebaseUser = currentFirebaseUser;
    if (firebaseUser != null) {
      return await _syncUserWithBackend(firebaseUser);
    }

    return null;
  }

  /// Connexion avec numéro de téléphone (Firebase Phone Auth)
  String? _verificationId;
  
  Future<void> signInWithPhoneNumber(
    String phoneNumber,
    {required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
    required Function() onAutoVerified}
  ) async {
    try {
      print('📱 Début de la vérification du numéro: $phoneNumber');
      
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('✅ Vérification automatique réussie');
          // Auto-vérification (Android uniquement)
          await _signInWithPhoneCredential(credential);
          onAutoVerified();
        },
        verificationFailed: (FirebaseAuthException e) {
          print('❌ Échec de la vérification: ${e.message}');
          onError(e.message ?? 'Erreur de vérification');
        },
        codeSent: (String verificationId, int? resendToken) {
          print('✅ Code envoyé, verificationId: $verificationId');
          _verificationId = verificationId;
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('⏱️  Timeout auto-retrieval');
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      print('❌ Erreur signInWithPhoneNumber: $e');
      onError(e.toString());
    }
  }

  /// Vérifier le code SMS
  Future<UserModel?> verifyPhoneCode(String smsCode) async {
    try {
      if (_verificationId == null) {
        print('❌ Pas de verificationId');
        return null;
      }

      print('🔐 Vérification du code SMS...');
      
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      return await _signInWithPhoneCredential(credential);
    } catch (e) {
      print('❌ Erreur verifyPhoneCode: $e');
      return null;
    }
  }

  /// Connexion avec les credentials téléphone
  Future<UserModel?> _signInWithPhoneCredential(PhoneAuthCredential credential) async {
    try {
      final UserCredential userCredential = 
          await _firebaseAuth.signInWithCredential(credential);
      
      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        print('❌ Échec de la connexion Firebase');
        return null;
      }

      print('✅ Firebase Auth réussi: ${firebaseUser.uid}');

      // Synchroniser avec le backend
      final userModel = await _syncUserWithBackend(firebaseUser);

      if (userModel != null) {
        await _saveUserToStorage(userModel);
        print('✅ Utilisateur sauvegardé dans le storage local');
      }

      return userModel;
    } catch (e) {
      print('❌ Erreur _signInWithPhoneCredential: $e');
      return null;
    }
  }
}
