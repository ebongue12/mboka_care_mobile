import 'package:flutter/material.dart';
import 'dart:convert';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool _isScanning = true;

  void _simulateScan() {
    // Simuler un scan après 2 secondes
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      
      // Données QR simulées
      final qrData = {
        'name': 'Marie DUPONT',
        'age': '35',
        'blood_group': 'A+',
        'allergies': 'Pénicilline',
        'chronic_conditions': 'Diabète type 2',
        'emergency_contact': '+237 677 888 999',
        'emergency_contact_name': 'Jean DUPONT',
      };

      setState(() => _isScanning = false);
      _showScannedData(qrData);
    });
  }

  void _showScannedData(Map<String, dynamic> data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.emergency, color: Colors.red.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'INFORMATIONS D\'URGENCE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                        Text(
                          data['name'] ?? 'Inconnu',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${data['age'] ?? '?'} ans'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _infoCard('🩸 Groupe Sanguin',
                        data['blood_group'] ?? 'Non renseigné', Colors.red),
                    _infoCard(
                        '⚠️ Allergies',
                        data['allergies']?.isNotEmpty == true
                            ? data['allergies']
                            : 'Aucune allergie connue',
                        Colors.orange),
                    _infoCard(
                        '🏥 Maladies Chroniques',
                        data['chronic_conditions']?.isNotEmpty == true
                            ? data['chronic_conditions']
                            : 'Aucune',
                        Colors.blue),
                    _infoCard(
                        '📞 Contact d\'Urgence',
                        '${data['emergency_contact_name'] ?? ''}\n${data['emergency_contact'] ?? 'Non renseigné'}',
                        Colors.green),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() => _isScanning = true);
                        _simulateScan();
                      },
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('Scanner à nouveau'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.check_circle),
                      label: const Text('OK'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).then((_) {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  Widget _infoCard(String label, String value, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(color: color, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _simulateScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Scanner QR Code',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Fond noir simulant la caméra
          Container(color: Colors.black),
          
          // Zone de scan
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color(0xFF4CAF50), width: 3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _isScanning
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(
                                color: Color(0xFF4CAF50),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Scan en cours...',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Placez le QR Code dans le cadre',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
