import 'package:flutter/material.dart';
import '../../../app/routes.dart';

class CareContactsScreen extends StatelessWidget {
  const CareContactsScreen({super.key});

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
        label: const Text('Ajouter', style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text('Gestion des proches - En développement'),
      ),
    );
  }
}
