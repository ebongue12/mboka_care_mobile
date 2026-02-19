import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/local_storage.dart';
import '../../../data/models/user_model.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;

  AuthState({required this.status, this.user, this.errorMessage});

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final ApiClient _apiClient;

  AuthNotifier(this._apiClient)
      : super(AuthState(status: AuthStatus.initial)) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final token = LocalStorage.getToken();
    state = state.copyWith(
      status: token != null
          ? AuthStatus.authenticated
          : AuthStatus.unauthenticated,
    );
  }

  Future<bool> login({
    required String phone,
    required String password,
  }) async {
    try {
      state = state.copyWith(status: AuthStatus.loading);
      final response = await _apiClient.login({
        'phone': phone,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        await LocalStorage.saveToken(data['access']);
        await LocalStorage.saveUserId(data['user']['id']);
        final user = UserModel.fromJson(data['user']);
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        );
        return true;
      }
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Identifiants incorrects',
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Erreur de connexion',
      );
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _apiClient.logout();
    } catch (_) {}
    await LocalStorage.clearAll();
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      user: null,
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ApiClient());
});
