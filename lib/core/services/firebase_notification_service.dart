import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebaseNotificationService {
  static final FirebaseNotificationService _instance = FirebaseNotificationService._internal();
  factory FirebaseNotificationService() => _instance;
  FirebaseNotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  String? _fcmToken;

  /// Initialiser Firebase
  Future<void> initialize() async {
    try {
      // Initialiser Firebase (nécessite google-services.json)
      await Firebase.initializeApp();
      
      // Demander permissions
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('✅ Permissions Firebase accordées');
        
        // Obtenir le token FCM
        _fcmToken = await _messaging.getToken();
        debugPrint('📱 FCM Token: $_fcmToken');
        
        // TODO: Envoyer ce token au backend pour enregistrer l'appareil
        
        // Écouter les messages en foreground
        FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
        
        // Messages en background
        FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
        
      } else {
        debugPrint('⚠️ Permissions Firebase refusées');
      }
    } catch (e) {
      debugPrint('❌ Erreur Firebase: $e');
      debugPrint('ℹ️ Firebase non configuré - Fonctionnement en mode local uniquement');
    }
  }

  /// Token FCM
  String? get fcmToken => _fcmToken;

  /// Envoyer token au backend
  Future<void> registerDevice(String userId) async {
    if (_fcmToken == null) return;
    
    // TODO: Appel API pour enregistrer le token
    debugPrint('📤 Envoi token FCM pour user: $userId');
    
    // await ApiClient().post('/notifications/register-device/', {
    //   'user_id': userId,
    //   'fcm_token': _fcmToken,
    //   'platform': 'android',
    // });
  }

  /// Message reçu en foreground
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('📬 Message foreground: ${message.notification?.title}');
    
    // Afficher notification locale avec AwesomeNotifications
    if (message.notification != null) {
      // TODO: Utiliser NotificationManager pour afficher
    }
  }

  /// Message quand app s'ouvre depuis notification
  void _handleBackgroundMessage(RemoteMessage message) {
    debugPrint('📭 Message background: ${message.notification?.title}');
  }
}
