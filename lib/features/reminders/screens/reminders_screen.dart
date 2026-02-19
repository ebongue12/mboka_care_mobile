import 'package:flutter/material.dart';
import '../../../app/routes.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Données fictives
    final reminders = [
      {
        'title': 'Paracétamol',
        'time': '08:00',
        'dosage': '500mg',
        'color': Colors.purple,
      },
      {
        'title': 'Vitamine D',
        'time': '12:00',
        'dosage': '1 comprimé',
        'color': Colors.orange,
      },
      {
        'title': 'Rendez-vous médecin',
        'time': '15:00',
        'dosage': 'Dr. Martin',
        'color': Colors.blue,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Rappels'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addReminder);
        },
        backgroundColor: const Color(0xFF2196F3),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (reminder['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.medication,
                    color: reminder['color'] as Color,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reminder['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${reminder['time']} • ${reminder['dosage']}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: true,
                  onChanged: (val) {},
                  activeColor: const Color(0xFF2196F3),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
