import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/error_handler.dart';
import '../../../data/models/patient_model.dart';

enum PatientStatus { initial, loading, loaded, error }

class PatientState {
  final PatientStatus status;
  final PatientModel? patient;
  final String? errorMessage;

  PatientState({
    required this.status,
    this.patient,
    this.errorMessage,
  });

  PatientState copyWith({
    PatientStatus? status,
    PatientModel? patient,
    String? errorMessage,
  }) {
    return PatientState(
      status: status ?? this.status,
      patient: patient ?? this.patient,
      errorMessage: errorMessage,
    );
  }
}

class PatientNotifier extends StateNotifier<PatientState> {
  final ApiClient _apiClient;

  PatientNotifier(this._apiClient)
      : super(PatientState(status: PatientStatus.initial));

  Future<void> loadProfile() async {
    state = state.copyWith(status: PatientStatus.loading);
    try {
      final response = await _apiClient.getPatientProfile();
      if (response.statusCode == 200) {
        final patient = PatientModel.fromJson(response.data);
        state = state.copyWith(
          status: PatientStatus.loaded,
          patient: patient,
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: PatientStatus.error,
        errorMessage: ErrorHandler.getMessage(e),
      );
    }
  }

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    state = state.copyWith(status: PatientStatus.loading);
    try {
      final response = await _apiClient.updatePatientProfile(data);
      if (response.statusCode == 200) {
        final patient = PatientModel.fromJson(response.data);
        state = state.copyWith(
          status: PatientStatus.loaded,
          patient: patient,
        );
        return true;
      }
      return false;
    } catch (e) {
      state = state.copyWith(
        status: PatientStatus.error,
        errorMessage: ErrorHandler.getMessage(e),
      );
      return false;
    }
  }
}

final patientProvider =
    StateNotifierProvider<PatientNotifier, PatientState>((ref) {
  return PatientNotifier(ApiClient());
});
