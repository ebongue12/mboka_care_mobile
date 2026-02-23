class ReminderModel {
  final String id;
  final String type; // 'medication' ou 'appointment'
  final String title;
  
  // Pour médicaments
  final String? medicationName;
  final String? dosage;
  final String? frequency;
  final List<String> timeSlots;
  final String? instructions;
  
  // Pour rendez-vous
  final DateTime? appointmentDate;
  final String? hospitalName;
  final String? doctorName;
  final String? reason;
  final String? location;
  
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastTaken;

  ReminderModel({
    required this.id,
    required this.type,
    required this.title,
    this.medicationName,
    this.dosage,
    this.frequency,
    this.timeSlots = const [],
    this.instructions,
    this.appointmentDate,
    this.hospitalName,
    this.doctorName,
    this.reason,
    this.location,
    required this.isActive,
    required this.createdAt,
    this.lastTaken,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'].toString(),
      type: json['type'],
      title: json['title'],
      medicationName: json['medication_name'],
      dosage: json['dosage'],
      frequency: json['frequency'],
      timeSlots: json['time_slots'] != null 
          ? List<String>.from(json['time_slots']) 
          : [],
      instructions: json['instructions'],
      appointmentDate: json['appointment_date'] != null
          ? DateTime.parse(json['appointment_date'])
          : null,
      hospitalName: json['hospital_name'],
      doctorName: json['doctor_name'],
      reason: json['reason'],
      location: json['location'],
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      lastTaken: json['last_taken'] != null
          ? DateTime.parse(json['last_taken'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'medication_name': medicationName,
      'dosage': dosage,
      'frequency': frequency,
      'time_slots': timeSlots,
      'instructions': instructions,
      'appointment_date': appointmentDate?.toIso8601String(),
      'hospital_name': hospitalName,
      'doctor_name': doctorName,
      'reason': reason,
      'location': location,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'last_taken': lastTaken?.toIso8601String(),
    };
  }
}
