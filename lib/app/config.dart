class AppConfig {
  // 🔥 URL DE VOTRE BACKEND DJANGO
  static const String apiBaseUrl = 'https://votre-backend-django.replit.dev/api/v1';
  
  // Configuration API
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Clés de stockage
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  
  // Version de l'app
  static const String appVersion = '1.0.0';
  static const String appName = 'MBOKA-CARE';
  
  // Mode debug
  static const bool debugMode = true;
}
