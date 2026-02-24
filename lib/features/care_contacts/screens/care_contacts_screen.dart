import 'package:flutter/material.dart';
import '../../../app/routes.dart';
import '../../../shared/widgets/slide_fade_transition.dart';

class CareContactsScreen extends StatefulWidget {
  const CareContactsScreen({super.key});

  @override
  State<CareContactsScreen> createState() => _CareContactsScreenState();
}

class _CareContactsScreenState extends State<CareContactsScreen> {
  final List<Map<String, dynamic>> _contacts = [
    {
      'name': 'Marie DUPONT',
      'phone': '+237 677 888 999',
      'relation': 'Épouse',
      'notifications': true,
    },
    {
      'name': 'Jean KAMGA',
      'phone': '+237 655 444 333',
      'relation': 'Frère',
      'notifications': true,
    },
    {
      'name': 'Dr. FOUDA',
      'phone': '+237 699 111 222',
      'relation': 'Médecin traitant',
      'notifications': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Proches'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addCareContact);
        },
        backgroundColor: const Color(0xFF4CAF50),
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text(
          'Ajouter',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.people,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suivi par vos proches',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Ils seront notifiés de vos prises de médicaments',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                return SlideFadeTransition(
                  delay: Duration(milliseconds: 100 * index),
                  child: _buildContactCard(_contacts[index], index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(Map<String, dynamic> contact, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFF2196F3).withOpacity(0.1),
            child: Text(
              contact['name'].toString().substring(0, 1),
              style: const TextStyle(
                color: Color(0xFF2196F3),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  contact['relation'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Text(
                  contact['phone'],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: contact['notifications'],
            onChanged: (val) {
              setState(() {
                _contacts[index]['notifications'] = val;
              });
            },
            activeColor: const Color(0xFF4CAF50),
          ),
        ],
      ),
    );
  }
}
EO
cd ~/workspace/mboka_care_mobile_backu
mkdir -p lib/features/care_contacts/screens

cat > lib/features/care_contacts/screens/care_contacts_screen.dart << 'EOF'
import 'package:flutter/material.dart';
import '../../../app/routes.dart';
import '../../../shared/widgets/slide_fade_transition.dart';

class CareContactsScreen extends StatefulWidget {
  const CareContactsScreen({super.key});

  @override
  State<CareContactsScreen> createState() => _CareContactsScreenState();
}

class _CareContactsScreenState extends State<CareContactsScreen> {
  final List<Map<String, dynamic>> _contacts = [
    {
      'name': 'Marie DUPONT',
      'phone': '+237 677 888 999',
      'relation': 'Épouse',
      'notifications': true,
    },
    {
      'name': 'Jean KAMGA',
      'phone': '+237 655 444 333',
      'relation': 'Frère',
      'notifications': true,
    },
    {
      'name': 'Dr. FOUDA',
      'phone': '+237 699 111 222',
      'relation': 'Médecin traitant',
      'notifications': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Proches'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addCareContact);
        },
        backgroundColor: const Color(0xFF4CAF50),
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text(
          'Ajouter',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.people,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suivi par vos proches',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Ils seront notifiés de vos prises de médicaments',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                return SlideFadeTransition(
                  delay: Duration(milliseconds: 100 * index),
                  child: _buildContactCard(_contacts[index], index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(Map<String, dynamic> contact, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFF2196F3).withOpacity(0.1),
            child: Text(
              contact['name'].toString().substring(0, 1),
              style: const TextStyle(
                color: Color(0xFF2196F3),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  contact['relation'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Text(
                  contact['phone'],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: contact['notifications'],
            onChanged: (val) {
              setState(() {
                _contacts[index]['notifications'] = val;
              });
            },
            activeColor: const Color(0xFF4CAF50),
          ),
        ],
      ),
    );
  }
}
