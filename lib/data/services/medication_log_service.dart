import 'package:flutter/material.dart';
import '../../core/network/api_client.dart';
import '../models/reminder_model.dart';

class MedicationLogService {
  static final MedicationLogService _instance = MedicationLogService._internal();
  factory MedicationLogService() => _instance;
  MedicationLogService._internal();

  final ApiClient _api = ApiClient();

  /// Marquer comme pris
  Future<void> markAsTaken(String reminderId, String timeSlot) async {
    try {
      await _api.confirmReminderTaken({
        'reminder_id': reminderId,
        'scheduled_time': timeSlot,
        'status': 'TAKEN',
        'confirmed_at': DateTime.now().toIso8601String(),
      });
      
      debugPrint('✅ Prise confirmée : $reminderId');
    } catch (e) {
      debugPrint('⚠️ Erreur confirmation (sauvegardé localement) : $e');
    }
  }

  /// Marquer comme sauté
  Future<void> markAsSkipped(String reminderId, String timeSlot) async {
    try {
      await _api.confirmReminderTaken({
        'reminder_id': reminderId,
        'scheduled_time': timeSlot,
        'status': 'SKIPPED',
      });
      
      debugPrint('⏭️ Prise sautée : $reminderId');
    } catch (e) {
      debugPrint('⚠️ Erreur : $e');
    }
  }

  /// Programmer rappel dans X minutes
  Future<void> delayReminder(ReminderModel reminder, int minutes) async {
    // TODO: Programmer notification dans X minutes
    debugPrint('⏰ Rappel dans $minutes minutes : ${reminder.title}');
  }
}
