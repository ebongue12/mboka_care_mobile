import 'dart:convert';
import '../storage/local_storage.dart';
import '../../data/models/reminder_model.dart';
import '../../data/models/care_contact_model.dart';

class LocalDataService {
  static const String _remindersKey = 'saved_reminders';
  static const String _contactsKey = 'saved_care_contacts';
  static const String _documentsKey = 'saved_documents';
  static const String _familyKey = 'saved_family';

static Future<List<ReminderModel>> getReminders() async {
    final prefs = LocalStorage._prefs;
    final String? remindersJson = prefs.getString(_remindersKey);
    
    if (remindersJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(remindersJson);
    return decoded.map((json) => ReminderModel.fromJson(json)).toList();
  }

  static Future<bool> saveReminder(ReminderModel reminder) async {
    final reminders = await getReminders();
    reminders.add(reminder);
    
    final prefs = LocalStorage._prefs;
    final encoded = jsonEncode(reminders.map((r) => r.toJson()).toList());
    return await prefs.setString(_remindersKey, encoded);
  }

  static Future<bool> updateReminder(ReminderModel reminder) async {
    final reminders = await getReminders();
    final index = reminders.indexWhere((r) => r.id == reminder.id);
    
    if (index == -1) return false;
    
    reminders[index] = reminder;
    
    final prefs = LocalStorage._prefs;
    final encoded = jsonEncode(reminders.map((r) => r.toJson()).toList());
    return await prefs.setString(_remindersKey, encoded);
  }

  static Future<bool> deleteReminder(String id) async {
    final reminders = await getReminders();
    reminders.removeWhere((r) => r.id == id);
    
    final prefs = LocalStorage._prefs;
    final encoded = jsonEncode(reminders.map((r) => r.toJson()).toList());
    return await prefs.setString(_remindersKey, encoded);
  }
static Future<List<CareContactModel>> getCareContacts() async {
    final prefs = LocalStorage._prefs;
    final String? contactsJson = prefs.getString(_contactsKey);
    
    if (contactsJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(contactsJson);
    return decoded.map((json) => CareContactModel.fromJson(json)).toList();
  }

  static Future<bool> saveCareContact(CareContactModel contact) async {
    final contacts = await getCareContacts();
    contacts.add(contact);
    
    final prefs = LocalStorage._prefs;
    final encoded = jsonEncode(contacts.map((c) => c.toJson()).toList());
    return await prefs.setString(_contactsKey, encoded);
  }

  static Future<bool> deleteCareContact(String id) async {
    final contacts = await getCareContacts();
    contacts.removeWhere((c) => c.id == id);
    
    final prefs = LocalStorage._prefs;
    final encoded = jsonEncode(contacts.map((c) => c.toJson()).toList());
    return await prefs.setString(_contactsKey, encoded);
  }
static Future<List<Map<String, dynamic>>> getDocuments() async {
    final prefs = LocalStorage._prefs;
    final String? docsJson = prefs.getString(_documentsKey);
    
    if (docsJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(docsJson);
    return decoded.cast<Map<String, dynamic>>();
  }

  static Future<bool> saveDocument(Map<String, dynamic> document) async {
    final documents = await getDocuments();
    documents.add(document);
    
    final prefs = LocalStorage._prefs;
    final encoded = jsonEncode(documents);
    return await prefs.setString(_documentsKey, encoded);
  }
static Future<List<Map<String, dynamic>>> getFamilyMembers() async {
    final prefs = LocalStorage._prefs;
    final String? familyJson = prefs.getString(_familyKey);
    
    if (familyJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(familyJson);
    return decoded.cast<Map<String, dynamic>>();
  }

  static Future<bool> saveFamilyMember(Map<String, dynamic> member) async {
    final family = await getFamilyMembers();
    family.add(member);
    
    final prefs = LocalStorage._prefs;
    final encoded = jsonEncode(family);
    return await prefs.setString(_familyKey, encoded);
  }
static Future<void> clearAll() async {
    final prefs = LocalStorage._prefs;
    await prefs.remove(_remindersKey);
    await prefs.remove(_contactsKey);
    await prefs.remove(_documentsKey);
    await prefs.remove(_familyKey);
  }
}
