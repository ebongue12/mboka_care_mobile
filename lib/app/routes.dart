import 'package:flutter/material.dart';
import '../features/splash/splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/onboarding/role_selection_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/home/home_screen.dart';
import '../features/qr/qr_screen.dart';
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
import '../features/doctor/screens/doctor_dashboard_screen.dart';
import '../features/hospital/screens/hospital_dashboard_screen.dart';
import '../features/care_contacts/screens/care_contacts_screen.dart';
import '../features/care_contacts/screens/add_care_contact_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String roleSelection = '/role-selection';
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
  static const String doctorDashboard = '/doctor-dashboard';
  static const String hospitalDashboard = '/hospital-dashboard';
  static const String careContacts = '/care-contacts';
  static const String addCareContact = '/add-care-contact';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case roleSelection:
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());
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
      case uploadDocument:
        return MaterialPageRoute(builder: (_) => const UploadDocumentScreen());
      case family:
        return MaterialPageRoute(builder: (_) => const FamilyScreen());
      case addFamilyMember:
        return MaterialPageRoute(builder: (_) => const AddFamilyMemberScreen());
      case medicalProfile:
        return MaterialPageRoute(builder: (_) => const MedicalProfileScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case healthStats:
        return MaterialPageRoute(builder: (_) => const HealthStatsScreen());
      case doctorDashboard:
        return MaterialPageRoute(builder: (_) => const DoctorDashboardScreen());
      case hospitalDashboard:
        return MaterialPageRoute(builder: (_) => const HospitalDashboardScreen());
      case careContacts:
        return MaterialPageRoute(builder: (_) => const CareContactsScreen());
      case addCareContact:
        return MaterialPageRoute(builder: (_) => const AddCareContactScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route ${settings.name} introuvable')),
          ),
        );
    }
  }
}
