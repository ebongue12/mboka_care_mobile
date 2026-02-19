import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  // Simuler des notifications (pour l'instant)
  Future<void> scheduleReminder({
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    debugPrint('📅 Rappel programmé: $title à $scheduledDate');
    // TODO: Implémenter avec flutter_local_notifications plus tard
  }

  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    debugPrint('🔔 Notification: $title - $body');
    // TODO: Implémenter avec flutter_local_notifications plus tard
  }

  Future<void> cancelReminder(String id) async {
    debugPrint('❌ Rappel annulé: $id');
  }

  Future<void> cancelAllReminders() async {
    debugPrint('❌ Tous les rappels annulés');
  }
}
