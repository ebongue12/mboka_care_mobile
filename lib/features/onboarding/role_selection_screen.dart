import 'package:flutter/material.dart';
import '../../app/routes.dart';
import '../../core/storage/local_storage.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/slide_fade_transition.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  Future<void> _selectRole(BuildContext context, String role) async {
    await LocalStorage.saveUserId(role); // Sauvegarder le rôle temporairement
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryBlue.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                
                // Logo
                SlideFadeTransition(
                  delay: const Duration(milliseconds: 100),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryBlue.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.health_and_safety,
                      size: 55,
                      color: Colors.white,
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                SlideFadeTransition(
                  delay: const Duration(milliseconds: 200),
                  child: const Text(
                    'MBOKA-CARE',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                SlideFadeTransition(
                  delay: const Duration(milliseconds: 300),
                  child: const Text(
                    'Choisissez votre profil',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
                
                const SizedBox(height: 60),
                
                // CARD PATIENT
                SlideFadeTransition(
                  delay: const Duration(milliseconds: 400),
                  child: _buildRoleCard(
                    context,
                    icon: Icons.person,
                    title: 'Patient',
                    description: 'Gérez votre santé et celle de votre famille',
                    gradient: AppTheme.primaryGradient,
                    onTap: () => _selectRole(context, 'patient'),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // CARD MÉDECIN
                SlideFadeTransition(
                  delay: const Duration(milliseconds: 500),
                  child: _buildRoleCard(
                    context,
                    icon: Icons.medical_services,
                    title: 'Médecin',
                    description: 'Accédez aux dossiers patients via QR Code',
                    gradient: AppTheme.successGradient,
                    onTap: () => _selectRole(context, 'doctor'),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // CARD HÔPITAL
                SlideFadeTransition(
                  delay: const Duration(milliseconds: 600),
                  child: _buildRoleCard(
                    context,
                    icon: Icons.local_hospital,
                    title: 'Hôpital',
                    description: 'Gérez les admissions et urgences',
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
                    ),
                    onTap: () => _selectRole(context, 'hospital'),
                  ),
                ),
                
                const Spacer(),
                
                SlideFadeTransition(
                  delay: const Duration(milliseconds: 700),
                  child: TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.login,
                    ),
                    child: const Text(
                      'Déjà inscrit ? Se connecter',
                      style: TextStyle(
                        color: AppTheme.primaryBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradient.colors.first.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
