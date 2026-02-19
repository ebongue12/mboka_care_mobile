class ReminderModel {
  final String id;
  final String title;
  final String? medicationName;
  final String? dosage;
  final String frequency;
  final List<String> timeSlots;
  final bool isActive;

  ReminderModel({
    required this.id,
    required this.title,
    this.medicationName,
    this.dosage,
    required this.frequency,
    required this.timeSlots,
    required this.isActive,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'],
      title: json['title'],
      medicationName: json['medication_name'],
      dosage: json['dosage'],
      frequency: json['frequency'],
      timeSlots: List<String>.from(json['time_slots'] ?? []),
      isActive: json['is_active'] ?? true,
    );
  }
}
