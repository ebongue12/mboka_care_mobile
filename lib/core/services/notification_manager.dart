import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import '../../data/models/reminder_model.dart';
import '../../data/services/medication_log_service.dart';
import '../../shared/widgets/medication_confirmation_dialog.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => _instance;
  NotificationManager._internal();

  bool _initialized = false;

  /// Initialiser les notifications
  Future<void> initialize() async {
    if (_initialized) return;

    await AwesomeNotifications().initialize(
      'resource://drawable/ic_launcher', // Icône
      [
        NotificationChannel(
          channelKey: 'medication_reminders',
          channelName: 'Rappels Médicaments',
          channelDescription: 'Notifications pour vos prises de médicaments',
          defaultColor: const Color(0xFF9C27B0),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          
          // SON D'ALARME FORT
          playSound: true,
          soundSource: 'resource://raw/res_alarm', // Son système
          enableVibration: true,
          vibrationPattern: highVibrationPattern, // Vibration forte
          enableLights: true,
          
          // CRITIQUES pour réveiller
          criticalAlerts: true,
          defaultPrivacy: NotificationPrivacy.Public,
        ),
      ],
      debug: true,
    );

    // Demander permissions critiques
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications(
          permissions: [
            NotificationPermission.Alert,
            NotificationPermission.Sound,
            NotificationPermission.Badge,
            NotificationPermission.Vibration,
            NotificationPermission.Light,
            NotificationPermission.CriticalAlert,
          ],
        );
      }
    });

    // Écouter les actions
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
    );

    _initialized = true;
  }

  /// Programmer un rappel avec ALARME SONORE
  Future<void> scheduleReminder(ReminderModel reminder) async {
    if (!_initialized) await initialize();

    await cancelReminder(reminder.id);

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
              ? 'Dose : ${reminder.dosage}\n\nTouchez pour confirmer'
              : 'Il est temps de prendre votre médicament',
          category: NotificationCategory.Alarm, // IMPORTANT : Type ALARM
          notificationLayout: NotificationLayout.Default,
          
          // RÉVEILLER L'ÉCRAN
          wakeUpScreen: true,
          fullScreenIntent: true,
          criticalAlert: true,
          
          // ACTIONS
          actionType: ActionType.Default,
          autoDismissible: false, // Ne pas disparaître automatiquement
          
          payload: {
            'reminder_id': reminder.id,
            'time_slot': timeSlot,
            'title': reminder.title,
            'dosage': reminder.dosage ?? '',
          },
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'TAKEN',
            label: '✓ J\'ai pris',
            actionType: ActionType.SilentAction,
            color: const Color(0xFF4CAF50),
          ),
          NotificationActionButton(
            key: 'DELAY',
            label: '⏰ Dans 5 min',
            actionType: ActionType.SilentAction,
            color: const Color(0xFF2196F3),
          ),
        ],
        schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
          second: 0,
          repeats: true,
          allowWhileIdle: true, // IMPORTANT : Sonner même en veille
        ),
      );

      debugPrint('✅ Alarme programmée : ${reminder.title} à $timeSlot');
    }
  }

  /// Annuler les notifications
  Future<void> cancelReminder(String reminderId) async {
    for (int i = 0; i < 10; i++) {
      final notifId = _generateNotificationId(reminderId, i);
      await AwesomeNotifications().cancel(notifId);
    }
  }

  /// Notification immédiate (test)
  Future<void> showImmediateNotification(String title, String body) async {
    if (!_initialized) await initialize();

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'medication_reminders',
        title: title,
        body: body,
        wakeUpScreen: true,
        criticalAlert: true,
        category: NotificationCategory.Alarm,
      ),
    );
  }

  /// Générer ID unique
  int _generateNotificationId(String reminderId, int index) {
    final lastChars = reminderId.substring(reminderId.length - 8);
    final base = int.parse(lastChars, radix: 16) % 100000;
    return base + index;
  }

  /// Callbacks
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification notification) async {
    debugPrint('📬 Notification créée: ${notification.title}');
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification notification) async {
    debugPrint('📱 Notification affichée: ${notification.title}');
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction action) async {
    debugPrint('👆 Action: ${action.buttonKeyPressed}');
    
    final reminderId = action.payload?['reminder_id'];
    final timeSlot = action.payload?['time_slot'];
    
    if (reminderId == null || timeSlot == null) return;
    
    final logService = MedicationLogService();
    
    if (action.buttonKeyPressed == 'TAKEN') {
      await logService.markAsTaken(reminderId, timeSlot);
    } else if (action.buttonKeyPressed == 'DELAY') {
      // TODO: Reprogrammer dans 5 min
    }
  }

  /// Afficher popup confirmation
  Future<void> showConfirmationDialog(BuildContext context, ReminderModel reminder, String timeSlot) async {
    final logService = MedicationLogService();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
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
}
