import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/api_client.dart';
import '../../core/storage/local_storage.dart';
import '../models/user_model.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;
  AuthState({required this.status, this.user, this.errorMessage});
  AuthState copyWith({AuthStatus? status, UserModel? user, String? errorMessage}) =>
    AuthState(status: status ?? this.status, user: user ?? this.user, errorMessage: errorMessage ?? this.errorMessage);
}

class AuthNotifier extends StateNotifier<AuthState> {
  final ApiClient _api;
  AuthNotifier(this._api) : super(AuthState(status: AuthStatus.initial)) { _check(); }

  void _check() {
    final token = LocalStorage.getAccessToken();
    state = state.copyWith(status: token != null ? AuthStatus.authenticated : AuthStatus.unauthenticated);
  }

  Future<bool> login({required String phone, required String password}) async {
    try {
      state = state.copyWith(status: AuthStatus.loading);
      final r = await _api.login({'phone': phone, 'password': password});
      if (r.statusCode == 200) {
        await LocalStorage.saveAccessToken(r.data['access']);
        await LocalStorage.saveRefreshToken(r.data['refresh']);
        final user = UserModel.fromJson(r.data['user']);
        await LocalStorage.saveUserId(user.id);
        await LocalStorage.saveUserRole(user.role);
        state = state.copyWith(status: AuthStatus.authenticated, user: user);
        return true;
      }
      state = state.copyWith(status: AuthStatus.error, errorMessage: 'Téléphone ou mot de passe incorrect');
      return false;
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, errorMessage: 'Erreur de connexion');
      return false;
    }
  }

  Future<bool> register(Map<String, dynamic> data) async {
    try {
      state = state.copyWith(status: AuthStatus.loading);
      final r = await _api.register(data);
      if (r.statusCode == 201) {
        await LocalStorage.saveAccessToken(r.data['access']);
        await LocalStorage.saveRefreshToken(r.data['refresh']);
        final user = UserModel.fromJson(r.data['user']);
        await LocalStorage.saveUserId(user.id);
        await LocalStorage.saveUserRole(user.role);
        state = state.copyWith(status: AuthStatus.authenticated, user: user);
        return true;
      }
      state = state.copyWith(status: AuthStatus.error, errorMessage: "Erreur d'inscription");
      return false;
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, errorMessage: 'Numéro déjà utilisé');
      return false;
    }
  }

  Future<void> logout() async {
    try { await _api.logout(); } catch (_) {}
    await LocalStorage.clearAll();
    state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
  }
}

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier(ref.watch(apiClientProvider)));
