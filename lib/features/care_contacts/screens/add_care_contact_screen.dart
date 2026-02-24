import 'package:flutter/material.dart';

class AddCareContactScreen extends StatelessWidget {
  const AddCareContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un proche'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Formulaire ajout proche - En développement'),
      ),
    );
  }
}
