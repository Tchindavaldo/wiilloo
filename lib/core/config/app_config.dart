/// Configuration de l'application
class AppConfig {
  // Délai d'affichage du message de succès de paiement (en millisecondes)
  static const int paymentSuccessDisplayDuration = 
      bool.fromEnvironment('dart.vm.product') ? 2000 : 4000; // 2s en prod, 4s en dev
  
  // Autres configurations...
  static const String appName = 'Wiilloo';
  static const String appVersion = '1.0.0';
}
