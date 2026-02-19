import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/qr/qr_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String qr = '/qr';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case qr:
        return MaterialPageRoute(builder: (_) => const QrScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route ${settings.name} introuvable')),
          ),
        );
    }
  }
}
