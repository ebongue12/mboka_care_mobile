import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/error_handler.dart';
import '../../../data/models/reminder_model.dart';

enum RemindersStatus { initial, loading, loaded, error }

class RemindersState {
  final RemindersStatus status;
  final List<ReminderModel> reminders;
  final String? errorMessage;

  RemindersState({
    required this.status,
    this.reminders = const [],
    this.errorMessage,
  });

  RemindersState copyWith({
    RemindersStatus? status,
    List<ReminderModel>? reminders,
    String? errorMessage,
  }) {
    return RemindersState(
      status: status ?? this.status,
      reminders: reminders ?? this.reminders,
      errorMessage: errorMessage,
    );
  }
}

class RemindersNotifier extends StateNotifier<RemindersState> {
  final ApiClient _apiClient;

  RemindersNotifier(this._apiClient)
      : super(RemindersState(status: RemindersStatus.initial));

  Future<void> loadReminders() async {
    state = state.copyWith(status: RemindersStatus.loading);
    try {
      final response = await _apiClient.getReminders();
      if (response.statusCode == 200) {
        final List<ReminderModel> reminders = (response.data['results'] as List)
            .map((json) => ReminderModel.fromJson(json))
            .toList();
        state = state.copyWith(
          status: RemindersStatus.loaded,
          reminders: reminders,
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: RemindersStatus.error,
        errorMessage: ErrorHandler.getMessage(e),
      );
    }
  }

  Future<bool> createReminder(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.createReminder(data);
      if (response.statusCode == 201) {
        await loadReminders();
        return true;
      }
      return false;
    } catch (e) {
      state = state.copyWith(
        status: RemindersStatus.error,
        errorMessage: ErrorHandler.getMessage(e),
      );
      return false;
    }
  }

  Future<bool> deleteReminder(String id) async {
    try {
      final response = await _apiClient.deleteReminder(id);
      if (response.statusCode == 204) {
        await loadReminders();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> confirmReminderTaken(String reminderId) async {
    try {
      final response = await _apiClient.confirmReminderTaken({
        'reminder_id': reminderId,
        'taken_at': DateTime.now().toIso8601String(),
      });
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}

final remindersProvider =
    StateNotifierProvider<RemindersNotifier, RemindersState>((ref) {
  return RemindersNotifier(ApiClient());
});
