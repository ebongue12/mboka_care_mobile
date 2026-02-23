class MedicationLogModel {
  final String id;
  final String reminderId;
  final DateTime scheduledTime;
  final DateTime? takenAt;
  final String status; // 'taken', 'missed', 'skipped'
  final String? notes;
  final bool notifiedContacts;

  MedicationLogModel({
    required this.id,
    required this.reminderId,
    required this.scheduledTime,
    this.takenAt,
    required this.status,
    this.notes,
    this.notifiedContacts = false,
  });

  factory MedicationLogModel.fromJson(Map<String, dynamic> json) {
    return MedicationLogModel(
      id: json['id'].toString(),
      reminderId: json['reminder_id'].toString(),
      scheduledTime: DateTime.parse(json['scheduled_time']),
      takenAt: json['taken_at'] != null
          ? DateTime.parse(json['taken_at'])
          : null,
      status: json['status'],
      notes: json['notes'],
      notifiedContacts: json['notified_contacts'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reminder_id': reminderId,
      'scheduled_time': scheduledTime.toIso8601String(),
      'taken_at': takenAt?.toIso8601String(),
      'status': status,
      'notes': notes,
      'notified_contacts': notifiedContacts,
    };
  }
}
