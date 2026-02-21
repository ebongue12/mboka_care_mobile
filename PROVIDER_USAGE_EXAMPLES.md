# 📚 Exemples d'Utilisation des Providers

## 1. Charger le Profil Patient
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientState = ref.watch(patientProvider);

    // Charger au démarrage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (patientState.status == PatientStatus.initial) {
        ref.read(patientProvider.notifier).loadProfile();
      }
    });

    return Scaffold(
      body: patientState.status == PatientStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : patientState.status == PatientStatus.error
              ? ErrorDisplayWidget(
                  message: patientState.errorMessage ?? 'Erreur',
                  onRetry: () => ref.read(patientProvider.notifier).loadProfile(),
                )
              : _buildProfile(patientState.patient!),
    );
  }
}
```

## 2. Mettre à Jour le Profil
```dart
Future<void> _saveProfile(WidgetRef ref) async {
  final success = await ref.read(patientProvider.notifier).updateProfile({
    'first_name': _firstNameController.text,
    'blood_group': _bloodGroup,
    'allergies': _allergiesController.text,
  });

  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil mis à jour ✓')),
    );
  }
}
```

## 3. Charger les Rappels
```dart
class RemindersScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersState = ref.watch(remindersProvider);

    useEffect(() {
      ref.read(remindersProvider.notifier).loadReminders();
      return null;
    }, []);

    return ListView.builder(
      itemCount: remindersState.reminders.length,
      itemBuilder: (context, index) {
        final reminder = remindersState.reminders[index];
        return ListTile(
          title: Text(reminder.title),
          subtitle: Text(reminder.dosage ?? ''),
        );
      },
    );
  }
}
```

## 4. Upload Document
```dart
Future<void> _uploadDocument(WidgetRef ref, File file) async {
  final success = await ref.read(documentsProvider.notifier).uploadDocument(
    filePath: file.path,
    title: _titleController.text,
    documentType: _docType,
  );

  if (success) {
    Navigator.pop(context);
  }
}
```

