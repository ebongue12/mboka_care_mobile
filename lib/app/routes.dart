import 'package:flutter/material.dart';
import '../features/splash/animated_splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/auth/screens/modern_login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/home/modern_home_screen.dart';
import '../features/qr/modern_qr_screen.dart';
import '../features/qr/scanner_screen.dart';
import '../features/reminders/screens/reminders_screen.dart';
import '../features/reminders/screens/add_reminder_screen.dart';
import '../features/documents/screens/documents_screen.dart';
import '../features/documents/screens/upload_document_screen.dart';
import '../features/family/screens/family_screen.dart';
import '../features/family/screens/add_family_member_screen.dart';
import '../features/patient/screens/medical_profile_screen.dart';
import '../features/patient/screens/settings_screen.dart';
import '../features/patient/screens/health_stats_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String qr = '/qr';
  static const String scanner = '/scanner';
  static const String reminders = '/reminders';
  static const String addReminder = '/add-reminder';
  static const String documents = '/documents';
  static const String uploadDocument = '/upload-document';
  static const String family = '/family';
  static const String addFamilyMember = '/add-family-member';
  static const String medicalProfile = '/medical-profile';
  static const String settings = '/settings';
  static const String healthStats = '/health-stats';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _fadeRoute(const AnimatedSplashScreen());
      case onboarding:
        return _slideRoute(const OnboardingScreen());
      case login:
        return _fadeRoute(const ModernLoginScreen());
      case register:
        return _slideRoute(const RegisterScreen());
      case home:
        return _fadeRoute(const ModernHomeScreen());
      case qr:
        return _slideRoute(const ModernQrScreen());
      case scanner:
        return _slideRoute(const ScannerScreen());
      case reminders:
        return _slideRoute(const RemindersScreen());
      case addReminder:
        return _slideRoute(const AddReminderScreen());
      case documents:
        return _slideRoute(const DocumentsScreen());
      case uploadDocument:
        return _slideRoute(const UploadDocumentScreen());
      case family:
        return _slideRoute(const FamilyScreen());
      case addFamilyMember:
        return _slideRoute(const AddFamilyMemberScreen());
      case medicalProfile:
        return _slideRoute(const MedicalProfileScreen());
      case '/settings':
        return _slideRoute(const SettingsScreen());
      case healthStats:
        return _slideRoute(const HealthStatsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'Route ${settings.name} introuvable',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }

  // Transition personnalisée Fade
  static Route _fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  // Transition personnalisée Slide
  static Route _slideRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
