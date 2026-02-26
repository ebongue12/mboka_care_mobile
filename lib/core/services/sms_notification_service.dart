import 'package:flutter/foundation.dart';
import '../../core/network/api_client.dart';
import '../../data/models/care_contact_model.dart';

class SmsNotificationService {
  static final SmsNotificationService _instance = SmsNotificationService._internal();
  factory SmsNotificationService() => _instance;
  SmsNotificationService._internal();

  final ApiClient _api = ApiClient();

  /// Notifier les proches par SMS
  Future<void> notifyContacts({
    required String patientName,
    required String medicationName,
    required List<CareContactModel> contacts,
  }) async {
    if (contacts.isEmpty) {
      debugPrint('⚠️ Aucun proche à notifier');
      return;
    }

    try {
      // Appel API backend qui envoie les SMS via Twilio
      await _api.dio.post('/notifications/notify-contacts/', data: {
        'patient_name': patientName,
        'medication_name': medicationName,
        'contacts': contacts.map((c) => {
          'phone': c.phone,
          'name': c.fullName,
        }).toList(),
        'message_type': 'medication_taken',
      });

      debugPrint('✅ SMS envoyés à ${contacts.length} proche(s)');
    } catch (e) {
      debugPrint('❌ Erreur envoi SMS: $e');
    }
  }

  /// Envoyer alerte si médicament manqué
  Future<void> sendMissedMedicationAlert({
    required String patientName,
    required String medicationName,
    required List<CareContactModel> contacts,
  }) async {
    if (contacts.isEmpty) return;

    try {
      await _api.dio.post('/notifications/missed-medication/', data: {
        'patient_name': patientName,
        'medication_name': medicationName,
        'contacts': contacts.map((c) => {
          'phone': c.phone,
          'name': c.fullName,
        }).toList(),
      });

      debugPrint('⚠️ Alerte médicament manqué envoyée');
    } catch (e) {
      debugPrint('❌ Erreur alerte: $e');
    }
  }
}
