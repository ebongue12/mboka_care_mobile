import '../../app/config.dart';
import 'package:flutter/material.dart';
import '../../data/models/reminder_model.dart';
import '../../data/models/care_contact_model.dart';
import '../network/api_client.dart';
import '../../app/config.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final ApiClient _apiClient = ApiClient();

  // Programmer une notification locale
  Future<void> scheduleReminder(ReminderModel reminder) async {
    if (AppConfig.debugMode) {
      debugPrint('📅 Programmation rappel: ${reminder.title}');
      debugPrint('   Type: ${reminder.type}');
      debugPrint('   Horaires: ${reminder.timeSlots}');
    }

    try {
      await _apiClient.dio.post('/reminders/schedule/', data: {
        'reminder_id': reminder.id,
        'time_slots': reminder.timeSlots,
      });
    } catch (e) {
      if (AppConfig.debugMode) {
        debugPrint('❌ Erreur programmation: $e');
      }
    }
  }

  // Afficher la confirmation de prise
  Future<bool?> showTakeConfirmation(
    BuildContext context,
    ReminderModel reminder,
  ) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.medication, color: Colors.blue.shade700),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Rappel médicament',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reminder.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (reminder.dosage != null) ...[
              const SizedBox(height: 8),
              Text(
                'Dosage: ${reminder.dosage}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
            if (reminder.instructions != null) ...[
              const SizedBox(height: 8),
              Text(
                reminder.instructions!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            const SizedBox(height: 16),
            const Text(
              'Avez-vous pris ce médicament ?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context, false),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Non'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Oui, pris'),
          ),
        ],
      ),
    );
  }

  // Confirmer la prise et notifier les proches
  Future<void> confirmMedicationTaken({
    required String reminderId,
    required bool taken,
    required List<CareContactModel> contacts,
  }) async {
    if (AppConfig.debugMode) {
      debugPrint('📝 Confirmation prise: $taken');
      debugPrint('   Nombre de contacts: ${contacts.length}');
    }

    try {
      // Enregistrer la prise
      await _apiClient.dio.post('/reminders/logs/', data: {
        'reminder_id': reminderId,
        'taken_at': DateTime.now().toIso8601String(),
        'status': taken ? 'taken' : 'missed',
      });

      // Notifier les proches
      if (contacts.isNotEmpty) {
        await _notifyCareContacts(
          reminderId: reminderId,
          taken: taken,
          contacts: contacts,
        );
      }
    } catch (e) {
      if (AppConfig.debugMode) {
        debugPrint('❌ Erreur confirmation: $e');
      }
    }
  }

  // Envoyer notification aux proches
  Future<void> _notifyCareContacts({
    required String reminderId,
    required bool taken,
    required List<CareContactModel> contacts,
  }) async {
    try {
      await _apiClient.dio.post('/notifications/care-contacts/', data: {
        'reminder_id': reminderId,
        'status': taken ? 'taken' : 'missed',
        'contact_ids': contacts.map((c) => c.id).toList(),
      });

      if (AppConfig.debugMode) {
        debugPrint('✅ ${contacts.length} proches notifiés');
      }
    } catch (e) {
      if (AppConfig.debugMode) {
        debugPrint('❌ Erreur notification proches: $e');
      }
    }
  }

  // Notification si pas de réponse après 2 minutes
  Future<void> handleNoResponse({
    required String reminderId,
    required List<CareContactModel> contacts,
  }) async {
    if (AppConfig.debugMode) {
      debugPrint('⚠️ Pas de réponse - notification proches');
    }

    try {
      await _apiClient.dio.post('/notifications/no-response/', data: {
        'reminder_id': reminderId,
        'contact_ids': contacts.map((c) => c.id).toList(),
      });
    } catch (e) {
      if (AppConfig.debugMode) {
        debugPrint('❌ Erreur: $e');
      }
    }
  }
}
