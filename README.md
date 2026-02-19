# MBOKA-CARE Mobile App

Application mobile Flutter pour la gestion de santé personnelle et familiale.

## 🚀 Fonctionnalités

### ✅ Implémentées
- 🔐 Authentification (Login/Register)
- 👤 Gestion du profil médical complet
- 📱 QR Code d'urgence (génération et affichage)
- 🔍 Scanner QR Code (version simulée)
- ⏰ Système de rappels médicaments
- 📄 Gestion de documents médicaux
- 📤 Upload de documents (photo/galerie/fichiers)
- 👨‍👩‍👧‍👦 Gestion de la famille
- 📊 Statistiques de santé
- 🔔 Service de notifications
- ⚙️ Paramètres utilisateur
- 🎨 Interface moderne et intuitive

### 🔄 À venir
- 📸 Scanner QR Code avec caméra réelle
- 🌐 Connexion au backend Django
- 🔔 Notifications push
- 💳 Système de paiement (Premium)
- 🏥 Module médecin
- 🏨 Module hôpital

## 🛠️ Technologies

- **Framework**: Flutter 3.24+
- **State Management**: Riverpod
- **Storage**: SharedPreferences
- **HTTP Client**: Dio
- **QR Code**: qr_flutter
- **Autres**: image_picker, file_picker, intl, google_fonts

## 📦 Installation
```bash
# Cloner le repo
git clone https://github.com/ebongue12/mboka_care_mobile.git

# Installer les dépendances
flutter pub get

# Lancer l'app
flutter run
```

## 🏗️ Structure du projet
```
lib/
├── app/                    # Configuration globale
├── core/                   # Services core (API, Storage)
├── data/                   # Modèles et providers
├── features/              # Fonctionnalités par module
│   ├── auth/
│   ├── patient/
│   ├── qr/
│   ├── reminders/
│   ├── documents/
│   └── family/
└── shared/                # Widgets partagés
```

## 🔗 Configuration Backend

Modifier `lib/app/config.dart` :
```dart
static const String apiBaseUrl = 'https://votre-backend.com/api/v1';
```

## 📱 Build APK
```bash
# Debug
flutter build apk --debug

# Release
flutter build apk --release
```

## 👨‍💻 Auteur

**Mbouma Ebongue Guillaume**
- GitHub: [@ebongue12](https://github.com/ebongue12)

## 📄 Licence

Ce projet est sous licence MIT.
