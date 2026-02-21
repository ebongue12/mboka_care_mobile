import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/routes.dart';
import 'core/storage/local_storage.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configuration de la barre de statut
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  // Initialiser le stockage local
  await LocalStorage.init();
  
  runApp(const ProviderScope(child: MbokaCareApp()));
}

class MbokaCareApp extends StatelessWidget {
  const MbokaCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MBOKA-CARE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
      
      // Configuration des transitions par défaut
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const _CustomScrollBehavior(),
          child: child!,
        );
      },
    );
  }
}

// Comportement de scroll personnalisé (plus fluide)
class _CustomScrollBehavior extends ScrollBehavior {
  const _CustomScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
