# 🚀 Guide de Déploiement MBOKA-CARE

## 📋 AVANT LE DÉPLOIEMENT

### 1. Configurer l'URL Backend
Modifiez `lib/app/config.dart` :
```dart
static const String apiBaseUrl = 'https://VOTRE-BACKEND.replit.dev/api/v1';
```

### 2. Vérifier que le Backend expose ces endpoints
- POST `/auth/register/`
- POST `/auth/login/`
- POST `/auth/logout/`
- GET  `/patients/me/`
- PUT  `/patients/me/`
- GET  `/patients/qr/`
- POST `/patients/qr/scan/`
- GET  `/reminders/`
- POST `/reminders/`
- GET  `/medical/documents/`
- POST `/medical/documents/`
- GET  `/patients/family-members/`

## 🏗️ BUILD PRODUCTION
```bash
# 1. Build APK Release
flutter build apk --release

# 2. L'APK sera dans :
build/app/outputs/flutter-apk/app-release.apk

# 3. Taille : ~40 MB (release)
```

## 📦 VERSION ACTUELLE

- **Version** : 1.0.0
- **Features** : ✅ Toutes implémentées
- **Backend Integration** : ✅ Prête
- **Providers Riverpod** : ✅ Configurés
- **API Client** : ✅ Complet

## ✅ CHECKLIST PRE-PRODUCTION

- [ ] URL backend configurée
- [ ] Backend testé et opérationnel
- [ ] Tous les endpoints répondent
- [ ] CORS configuré sur Django
- [ ] JWT tokens fonctionnels
- [ ] Test de connexion réussi
- [ ] Test d'inscription réussi
- [ ] Mode debug désactivé (`AppConfig.debugMode = false`)
- [ ] Icône app personnalisée
- [ ] Screenshots préparés

## 🎯 FONCTIONNALITÉS FINALES

✅ Authentification complète (Register/Login/Logout)  
✅ Profil patient avec édition  
✅ QR Code génération  
✅ Scanner QR (simulé)  
✅ Rappels médicaments  
✅ Upload documents  
✅ Gestion famille  
✅ Statistiques santé  
✅ Paramètres  
✅ Stockage local  
✅ Gestion d'erreurs  
✅ Loading states  
✅ Navigation complète  

## 🔒 SÉCURITÉ

- Tokens JWT stockés en local (SharedPreferences)
- Expiration auto (401 → déconnexion)
- HTTPS requis en production
- Validation des entrées utilisateur

