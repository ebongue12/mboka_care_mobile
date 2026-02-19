import 'package:flutter/material.dart';
import '../features/splash/splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/home/home_screen.dart';
import '../features/qr/qr_screen.dart';
import '../features/qr/scanner_screen.dart';
import '../features/reminders/screens/reminders_screen.dart';
import '../features/reminders/screens/add_reminder_screen.dart';
import '../features/documents/screens/documents_screen.dart';
import '../features/family/screens/family_screen.dart';
import '../features/documents/screens/upload_document_screen.dart';

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
  static const String family = '/family';
  static const String uploadDocument = '/upload-document';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case qr:
        return MaterialPageRoute(builder: (_) => const QrScreen());
      case scanner:
        return MaterialPageRoute(builder: (_) => const ScannerScreen());
      case reminders:
        return MaterialPageRoute(builder: (_) => const RemindersScreen());
      case addReminder:
        return MaterialPageRoute(builder: (_) => const AddReminderScreen());
      case documents:
        return MaterialPageRoute(builder: (_) => const DocumentsScreen());
      case family:
      case uploadDocument:
        return MaterialPageRoute(builder: (_) => const UploadDocumentScreen());
        return MaterialPageRoute(builder: (_) => const FamilyScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route ${settings.name} introuvable')),
          ),
        );
    }
  }
}
