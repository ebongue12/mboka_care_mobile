import 'package:flutter/foundation.dart';
import '../../core/network/api_client.dart';
import '../../core/services/local_data_service.dart';
import '../../core/storage/local_storage.dart';
import '../models/reminder_model.dart';
import '../models/care_contact_model.dart';

/// Service unifié : Local + API + Sync automatique
class DataSyncService {
  static final DataSyncService _instance = DataSyncService._internal();
  factory DataSyncService() => _instance;
  DataSyncService._internal();

  final ApiClient _api = ApiClient();
  bool _isOnline = true;

  /// ========================================
  /// RAPPELS (Reminders)
  /// ========================================

  Future<List<ReminderModel>> getReminders({bool forceSync = false}) async {
    // Toujours charger le local d'abord (rapide)
    final localReminders = await LocalDataService.getReminders();

    // Essayer de sync avec backend
    if (forceSync || _shouldSync()) {
      try {
        final response = await _api.getReminders();
        if (response.statusCode == 200) {
          final List<dynamic> data = response.data;
          final apiReminders = data.map((json) => ReminderModel.fromJson(json)).toList();
          
          // Sauvegarder localement pour offline
          for (var reminder in apiReminders) {
            await LocalDataService.saveReminder(reminder);
          }
          
          _isOnline = true;
          return apiReminders;
        }
      } catch (e) {
        _isOnline = false;
        if (kDebugMode) print('⚠️ Offline - Utilisation cache local');
      }
    }

    return localReminders;
  }

  Future<bool> saveReminder(ReminderModel reminder) async {
    // Sauvegarder local d'abord (garantie)
    final localSaved = await LocalDataService.saveReminder(reminder);

    // Essayer de sync au backend
    try {
      await _api.createReminder(reminder.toJson());
      _isOnline = true;
    } catch (e) {
      _isOnline = false;
      if (kDebugMode) print('⚠️ Rappel sauvegardé localement, sync plus tard');
    }

    return localSaved;
  }

  Future<bool> deleteReminder(String id) async {
    // Supprimer local
    final localDeleted = await LocalDataService.deleteReminder(id);

    // Essayer de sync au backend
    try {
      await _api.deleteReminder(id);
      _isOnline = true;
    } catch (e) {
      _isOnline = false;
    }

    return localDeleted;
  }

  /// ========================================
  /// PROCHES (Care Contacts)
  /// ========================================

  Future<List<CareContactModel>> getCareContacts({bool forceSync = false}) async {
    final localContacts = await LocalDataService.getCareContacts();

    if (forceSync || _shouldSync()) {
      try {
        final response = await _api.getCareContacts();
        if (response.statusCode == 200) {
          final List<dynamic> data = response.data;
          final apiContacts = data.map((json) => CareContactModel.fromJson(json)).toList();
          
          for (var contact in apiContacts) {
            await LocalDataService.saveCareContact(contact);
          }
          
          _isOnline = true;
          return apiContacts;
        }
      } catch (e) {
        _isOnline = false;
      }
    }

    return localContacts;
  }

  Future<bool> saveCareContact(CareContactModel contact) async {
    final localSaved = await LocalDataService.saveCareContact(contact);

    try {
      await _api.addCareContact(contact.toJson());
      _isOnline = true;
    } catch (e) {
      _isOnline = false;
    }

    return localSaved;
  }

  Future<bool> deleteCareContact(String id) async {
    final localDeleted = await LocalDataService.deleteCareContact(id);

    try {
      await _api.deleteCareContact(id);
      _isOnline = true;
    } catch (e) {
      _isOnline = false;
    }

    return localDeleted;
  }

  /// ========================================
  /// FAMILLE
  /// ========================================

  Future<List<Map<String, dynamic>>> getFamilyMembers({bool forceSync = false}) async {
    final localFamily = await LocalDataService.getFamilyMembers();

    if (forceSync || _shouldSync()) {
      try {
        final response = await _api.getFamilyMembers();
        if (response.statusCode == 200) {
          final List<dynamic> data = response.data;
          
          for (var member in data) {
            await LocalDataService.saveFamilyMember(member);
          }
          
          _isOnline = true;
          return List<Map<String, dynamic>>.from(data);
        }
      } catch (e) {
        _isOnline = false;
      }
    }

    return localFamily;
  }

  /// ========================================
  /// UTILITAIRES
  /// ========================================

  bool _shouldSync() {
    // Sync toutes les 5 minutes max
    return true; // À améliorer avec un timestamp
  }

  bool get isOnline => _isOnline;

  /// Forcer la synchronisation complète
  Future<void> syncAll() async {
    await getReminders(forceSync: true);
    await getCareContacts(forceSync: true);
    await getFamilyMembers(forceSync: true);
  }
}
