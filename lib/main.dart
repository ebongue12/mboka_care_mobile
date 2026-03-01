import 'package:flutter/material.dart';
import 'app/routes.dart';
import 'core/storage/local_storage.dart';
import 'core/theme/app_theme.dart';
import 'core/services/notification_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await LocalStorage.init();
  await NotificationManager().initialize();
  
  runApp(const MbokaCareApp());
}

class MbokaCareApp extends StatelessWidget {
  const MbokaCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MBOKA-CARE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.splash,
    );
  }
}
