class UserModel {
  final String id;
  final String phone;
  final String? email;
  final String role;

  UserModel({
    required this.id,
    required this.phone,
    this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      phone: json['phone'],
      email: json['email'],
      role: json['role'],
    );
  }
}
