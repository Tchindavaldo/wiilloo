import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';
  static String get socketUrl => dotenv.env['SOCKET_URL'] ?? 'http://localhost:3000';
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';
  
  static bool get isDevelopment => environment == 'development';
  static bool get isProduction => environment == 'production';
  
  /// Initialize environment configuration
  /// Use .env.development for development
  /// Use .env.production for production
  static Future<void> initialize({bool isProduction = false}) async {
    final envFile = isProduction ? '.env.production' : '.env.development';
    await dotenv.load(fileName: envFile);
  }
}
