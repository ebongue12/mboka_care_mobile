import 'package:flutter/material.dart';
import '../../../app/routes.dart';

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final members = [
      {
        'name': 'Marie DUPONT',
        'relation': 'Épouse',
        'age': '35 ans',
        'icon': Icons.person,
      },
      {
        'name': 'Lucas DUPONT',
        'relation': 'Fils',
        'age': '8 ans',
        'icon': Icons.child_care,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Famille'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addFamilyMember);
        },
        backgroundColor: const Color(0xFF2196F3),
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
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
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFF2196F3).withOpacity(0.1),
                  child: Icon(
                    member['icon'] as IconData,
                    color: const Color(0xFF2196F3),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${member['relation']} • ${member['age']}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
