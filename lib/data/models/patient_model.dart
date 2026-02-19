class PatientModel {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String? bloodGroup;
  final String? allergies;
  final String? chronicConditions;
  final String? emergencyContactName;
  final String? emergencyContactPhone;

  PatientModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    this.bloodGroup,
    this.allergies,
    this.chronicConditions,
    this.emergencyContactName,
    this.emergencyContactPhone,
  });

  String get fullName => '$firstName $lastName';

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      bloodGroup: json['blood_group'],
      allergies: json['allergies'],
      chronicConditions: json['chronic_conditions'],
      emergencyContactName: json['emergency_contact_name'],
      emergencyContactPhone: json['emergency_contact_phone'],
    );
  }
}
