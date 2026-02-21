import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with phone and password
  Future<UserCredential?> signUpWithPhoneAndPassword(
      String phone, String password) async {
    try {
      // Create user with email (Firebase doesn't support phone+password directly)
      // We'll use phone as email for now, then update profile
      String email = '$phone@wiilloo.app';
      
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Update user profile with phone number
      await result.user?.updateDisplayName(phone);
      
      // Send email verification (optional)
      await result.user?.sendEmailVerification();
      
      return result;
    } on FirebaseAuthException catch (e) {
      debugPrint('Sign up error: ${e.message}');
      throw _getErrorMessage(e);
    } catch (e) {
      debugPrint('Unexpected sign up error: $e');
      throw 'Une erreur inattendue est survenue';
    }
  }

  // Sign in with phone and password
  Future<UserCredential?> signInWithPhoneAndPassword(
      String phone, String password) async {
    try {
      // Convert phone to email format
      String email = '$phone@wiilloo.app';
      
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      debugPrint('Sign in error: ${e.message}');
      throw _getErrorMessage(e);
    } catch (e) {
      debugPrint('Unexpected sign in error: $e');
      throw 'Une erreur inattendue est survenue';
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw 'Connexion Google annulée';
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      debugPrint('Google sign in error: ${e.message}');
      throw _getErrorMessage(e);
    } catch (e) {
      debugPrint('Unexpected Google sign in error: $e');
      throw 'Une erreur inattendue est survenue';
    }
  }

  // Phone number authentication (SMS verification)
  Future<void> verifyPhoneNumber(String phoneNumber,
      {required Function(String verificationId, int? forceResendingToken) onCodeSent,
      required Function(FirebaseAuthException) onVerificationFailed,
      required Function(PhoneAuthCredential) onVerificationCompleted}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // Sign in with phone credential (after SMS verification)
  Future<UserCredential?> signInWithPhoneCredential(
      PhoneAuthCredential credential) async {
    try {
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      debugPrint('Phone sign in error: ${e.message}');
      throw _getErrorMessage(e);
    } catch (e) {
      debugPrint('Unexpected phone sign in error: $e');
      throw 'Une erreur inattendue est survenue';
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      debugPrint('Sign out error: $e');
      throw 'Erreur lors de la déconnexion';
    }
  }

  // Reset password
  Future<void> resetPassword(String phone) async {
    try {
      // Convert phone to email format
      String email = '$phone@wiilloo.app';
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      debugPrint('Reset password error: ${e.message}');
      throw _getErrorMessage(e);
    } catch (e) {
      debugPrint('Unexpected reset password error: $e');
      throw 'Une erreur inattendue est survenue';
    }
  }

  // Check if email is verified
  bool isEmailVerified() {
    return _auth.currentUser?.emailVerified ?? false;
  }

  // Send email verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      debugPrint('Send email verification error: $e');
      throw 'Erreur lors de l\'envoi de l\'email de vérification';
    }
  }

  // Update user profile
  Future<void> updateUserProfile({String? displayName, String? photoURL}) async {
    try {
      await _auth.currentUser?.updateDisplayName(displayName);
      await _auth.currentUser?.updatePhotoURL(photoURL);
    } catch (e) {
      debugPrint('Update profile error: $e');
      throw 'Erreur lors de la mise à jour du profil';
    }
  }

  // Delete user account
  Future<void> deleteUser() async {
    try {
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      debugPrint('Delete user error: ${e.message}');
      throw _getErrorMessage(e);
    } catch (e) {
      debugPrint('Unexpected delete user error: $e');
      throw 'Une erreur inattendue est survenue';
    }
  }

  // Get user-friendly error messages
  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Le mot de passe est trop faible (minimum 6 caractères)';
      case 'email-already-in-use':
        return 'Ce numéro de téléphone est déjà utilisé par un autre compte';
      case 'user-not-found':
        return 'Aucun utilisateur trouvé avec ce numéro de téléphone';
      case 'wrong-password':
        return 'Mot de passe incorrect';
      case 'invalid-email':
        return 'Le numéro de téléphone n\'est pas valide';
      case 'user-disabled':
        return 'Ce compte a été désactivé';
      case 'too-many-requests':
        return 'Trop de tentatives de connexion. Veuillez réessayer plus tard';
      case 'operation-not-allowed':
        return 'Cette opération n\'est pas autorisée';
      case 'account-exists-with-different-credential':
        return 'Un compte existe déjà avec ce numéro mais avec une autre méthode de connexion';
      case 'invalid-credential':
        return 'Les informations d\'identification sont invalides';
      case 'network-request-failed':
        return 'Erreur de connexion. Vérifiez votre connexion internet';
      case 'invalid-phone-number':
        return 'Le numéro de téléphone n\'est pas valide';
      case 'quota-exceeded':
        return 'Le quota SMS a été dépassé. Veuillez réessayer plus tard';
      default:
        return 'Une erreur est survenue: ${e.message}';
    }
  }
}
