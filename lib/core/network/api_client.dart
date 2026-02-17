import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../app/constants.dart';
import '../storage/local_storage.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio _dio;
  factory ApiClient() => _instance;

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = LocalStorage.getAccessToken();
        if (token != null) options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
    ));
    _dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true, compact: true));
  }

  Dio get dio => _dio;
  Future<Response> register(Map<String, dynamic> data) async => await _dio.post('/auth/register/', data: data);
  Future<Response> login(Map<String, dynamic> data) async => await _dio.post('/auth/login/', data: data);
  Future<Response> logout() async => await _dio.post('/auth/logout/');
  Future<Response> getPatientProfile() async => await _dio.get('/patients/me/');
  Future<Response> updatePatientProfile(Map<String, dynamic> data) async => await _dio.put('/patients/me/', data: data);
  Future<Response> generatePatientQR() async => await _dio.get('/patients/qr/generate/');
  Future<Response> getDocuments() async => await _dio.get('/medical/documents/');
  Future<Response> uploadDocument(FormData formData) async => await _dio.post('/medical/documents/', data: formData);
  Future<Response> getReminders() async => await _dio.get('/reminders/');
  Future<Response> createReminder(Map<String, dynamic> data) async => await _dio.post('/reminders/', data: data);
  Future<Response> getNotifications() async => await _dio.get('/notifications/');
}
