import 'package:dio/dio.dart';
import '../storage/local_storage.dart';
import '../../app/config.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio _dio;

  factory ApiClient() => _instance;

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: AppConfig.connectTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = LocalStorage.getToken();
        if (token != null && token != 'onboarding_done') {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          LocalStorage.clearAll();
        }
        return handler.next(error);
      },
    ));
  }

  Dio get dio => _dio;

  // Auth
  Future<Response> register(Map<String, dynamic> data) async {
    return await _dio.post('/auth/register/', data: data);
  }

  Future<Response> login(Map<String, dynamic> data) async {
    return await _dio.post('/auth/login/', data: data);
  }

  Future<Response> logout() async {
    return await _dio.post('/auth/logout/');
  }

  // Patient
  Future<Response> getPatientProfile() async {
    return await _dio.get('/patients/me/');
  }

  Future<Response> updatePatientProfile(Map<String, dynamic> data) async {
    return await _dio.put('/patients/me/', data: data);
  }

  // QR Code
  Future<Response> generatePatientQR() async {
    return await _dio.get('/patients/qr/generate/');
  }

  Future<Response> getPatientQR() async {
    return await _dio.get('/patients/qr/');
  }

  Future<Response> scanQR(Map<String, dynamic> data) async {
    return await _dio.post('/patients/qr/scan/', data: data);
  }

  // Documents
  Future<Response> getDocuments() async {
    return await _dio.get('/medical/documents/');
  }

  Future<Response> uploadDocument(FormData formData) async {
    return await _dio.post('/medical/documents/', data: formData);
  }

  Future<Response> deleteDocument(String id) async {
    return await _dio.delete('/medical/documents/$id/');
  }

  // Reminders
  Future<Response> getReminders() async {
    return await _dio.get('/reminders/');
  }

  Future<Response> createReminder(Map<String, dynamic> data) async {
    return await _dio.post('/reminders/', data: data);
  }

  Future<Response> updateReminder(String id, Map<String, dynamic> data) async {
    return await _dio.put('/reminders/$id/', data: data);
  }

  Future<Response> deleteReminder(String id) async {
    return await _dio.delete('/reminders/$id/');
  }

  Future<Response> confirmReminderTaken(Map<String, dynamic> data) async {
    return await _dio.post('/reminders/logs/', data: data);
  }

  // Care Contacts (Proches)
  Future<Response> getCareContacts() async {
    return await _dio.get('/patients/care-contacts/');
  }

  Future<Response> addCareContact(Map<String, dynamic> data) async {
    return await _dio.post('/patients/care-contacts/', data: data);
  }

  Future<Response> updateCareContact(String id, Map<String, dynamic> data) async {
    return await _dio.put('/patients/care-contacts/$id/', data: data);
  }

  Future<Response> deleteCareContact(String id) async {
    return await _dio.delete('/patients/care-contacts/$id/');
  }

  // Family
  Future<Response> getFamilyMembers() async {
    return await _dio.get('/patients/family-members/');
  }

  Future<Response> addFamilyMember(Map<String, dynamic> data) async {
    return await _dio.post('/patients/family-members/', data: data);
  }

  // Notifications
  Future<Response> getNotifications() async {
    return await _dio.get('/notifications/');
  }

  Future<Response> markNotificationRead(String id) async {
    return await _dio.patch('/notifications/$id/read/');
  }

  // Statistics
  Future<Response> getHealthStats() async {
    return await _dio.get('/patients/stats/');
  }
}
