class CareContactModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String relation; // 'parent', 'conjoint', 'ami', 'autre'
  final bool receiveNotifications;
  final DateTime createdAt;

  CareContactModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.relation,
    this.receiveNotifications = true,
    required this.createdAt,
  });

  String get fullName => '$firstName $lastName';

  factory CareContactModel.fromJson(Map<String, dynamic> json) {
    return CareContactModel(
      id: json['id'].toString(),
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      relation: json['relation'],
      receiveNotifications: json['receive_notifications'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'relation': relation,
      'receive_notifications': receiveNotifications,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
