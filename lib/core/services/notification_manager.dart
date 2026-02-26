import 'package:awesome_notifications/awesome_notifications.dart';
import '../../data/services/medication_log_service.dart';
import '../../shared/widgets/medication_confirmation_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../../data/models/reminder_model.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => _instance;
  NotificationManager._internal();

  bool _initialized = false;

  /// Initialiser les notifications
  Future<void> initialize() async {
    if (_initialized) return;

    await AwesomeNotifications().initialize(
      null, // Icône par défaut
      [
        NotificationChannel(
          channelKey: 'medication_reminders',
          channelName: 'Rappels Médicaments',
          channelDescription: 'Notifications pour vos prises de médicaments',
          defaultColor: const Color(0xFF9C27B0),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          playSound: true,
          enableVibration: true,
          enableLights: true,
        ),
      ],
      debug: true,
    );

    // Demander permissions
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    // Écouter les actions (quand user tape sur notif)
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
    );

    _initialized = true;
  }

  /// Programmer un rappel quotidien
  Future<void> scheduleReminder(ReminderModel reminder) async {
    if (!_initialized) await initialize();

    // Supprimer anciennes notifications pour ce rappel
    await cancelReminder(reminder.id);

    // Programmer pour chaque créneau horaire
    for (int i = 0; i < reminder.timeSlots.length; i++) {
      final timeSlot = reminder.timeSlots[i];
      final parts = timeSlot.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: _generateNotificationId(reminder.id, i),
          channelKey: 'medication_reminders',
          title: '💊 ${reminder.title}',
          body: reminder.dosage != null 
              ? 'Dose : ${reminder.dosage}'
              : 'Il est temps de prendre votre médicament',
          category: NotificationCategory.Reminder,
          notificationLayout: NotificationLayout.Default,
          wakeUpScreen: true,
          fullScreenIntent: true,
          criticalAlert: true,
          payload: {
            'reminder_id': reminder.id,
            'time_slot': timeSlot,
            'title': reminder.title,
          },
        ),
        schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
          second: 0,
          repeats: true, // Répéter chaque jour
        ),
      );

      debugPrint('✅ Notification programmée : ${reminder.title} à $timeSlot');
    }
  }

  /// Annuler les notifications d'un rappel
  Future<void> cancelReminder(String reminderId) async {
    // Annuler jusqu'à 10 créneaux possibles
    for (int i = 0; i < 10; i++) {
      final notifId = _generateNotificationId(reminderId, i);
      await AwesomeNotifications().cancel(notifId);
    }
  }

  /// Afficher notification immédiate (test)
  Future<void> showImmediateNotification(String title, String body) async {
    if (!_initialized) await initialize();

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'medication_reminders',
        title: title,
        body: body,
        wakeUpScreen: true,
      ),
    );
  }

  /// Générer ID unique pour notification
  int _generateNotificationId(String reminderId, int index) {
    final lastChars = reminderId.substring(reminderId.length - 8);
    final base = int.parse(lastChars, radix: 16) % 100000;
    return base + index;
  }

  /// Callback quand notification est créée
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification notification) async {
    debugPrint('📬 Notification créée: ${notification.title}');
  }

  /// Callback quand notification est affichée
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification notification) async {
    debugPrint('📱 Notification affichée: ${notification.title}');
  }

  /// Callback quand user tape sur notification
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction action) async {
    debugPrint('👆 Action reçue: ${action.payload}');
    
    // TODO: Ouvrir popup "As-tu pris ?"
    // On va implémenter ça dans la PHASE 2
  }
}

  /// Afficher popup confirmation
  Future<void> showConfirmationDialog(BuildContext context, ReminderModel reminder, String timeSlot) async {
    final logService = MedicationLogService();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false, // Empêcher fermeture avec back
        child: MedicationConfirmationDialog(
          reminder: reminder,
          onTaken: () async {
            await logService.markAsTaken(reminder.id, timeSlot);
            
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✓ Prise confirmée !'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
            
            // TODO PHASE 4: Notifier les proches
          },
          onSkipped: () async {
            await logService.markAsSkipped(reminder.id, timeSlot);
            
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Prise sautée'),
                backgroundColor: Colors.orange,
              ),
            );
          },
          onDelayed: () async {
            await logService.delayReminder(reminder, 5);
            
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('⏰ Rappel dans 5 minutes'),
                backgroundColor: Colors.blue,
              ),
            );
          },
        ),
      ),
    );
  }
