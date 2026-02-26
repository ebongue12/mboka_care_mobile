import 'package:flutter/material.dart';
import '../../data/models/reminder_model.dart';

class MedicationConfirmationDialog extends StatelessWidget {
  final ReminderModel reminder;
  final VoidCallback onTaken;
  final VoidCallback onSkipped;
  final VoidCallback onDelayed;

  const MedicationConfirmationDialog({
    super.key,
    required this.reminder,
    required this.onTaken,
    required this.onSkipped,
    required this.onDelayed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icône animée
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.medication,
                size: 40,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 16),
            
            const Text(
              '💊 C\'est l\'heure !',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              reminder.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9C27B0),
              ),
              textAlign: TextAlign.center,
            ),
            
            if (reminder.dosage != null) ...[
              const SizedBox(height: 4),
              Text(
                reminder.dosage!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            
            const SizedBox(height: 24),
            
            const Text(
              'As-tu pris ton médicament ?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 24),
            
            // Bouton "Oui, pris"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  onTaken();
                },
                icon: const Icon(Icons.check_circle, color: Colors.white),
                label: const Text(
                  'Oui, j\'ai pris',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Bouton "Rappeler dans 5 min"
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  onDelayed();
                },
                icon: const Icon(Icons.schedule),
                label: const Text(
                  'Rappeler dans 5 min',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Bouton "Sauter"
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onSkipped();
              },
              child: const Text(
                'Sauter cette prise',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: Ajouter import
// import '../../core/services/sms_notification_service.dart';
// import '../../data/services/data_sync_service.dart';

// Dans onTaken(), ajouter après logService.markAsTaken() :
// 
// // Récupérer les proches
// final contacts = await DataSyncService().getCareContacts();
// final notifiableContacts = contacts.where((c) => c.receiveNotifications).toList();
//
// // Notifier par SMS
// if (notifiableContacts.isNotEmpty) {
//   await SmsNotificationService().notifyContacts(
//     patientName: 'Patient', // TODO: Récupérer nom réel
//     medicationName: reminder.title,
//     contacts: notifiableContacts,
//   );
// }
