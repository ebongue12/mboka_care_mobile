# 🚀 Guide de Démarrage Rapide - MBOKA-CARE

## 📱 Installation & Test

### 1. Télécharger l'APK
```
1. Allez sur: github.com/ebongue12/mboka_care_mobile/actions
2. Cliquez sur le dernier build ✅ vert
3. Téléchargez "mboka-care-debug" (Artifacts)
4. Décompressez le ZIP
5. Installez app-debug.apk sur Android
```

### 2. Première Utilisation

**Splash Screen (3s)**
- Animation de logo avec effet pulse
- Cercles animés

**Onboarding (3 slides)**
- Swipez pour découvrir les fonctionnalités
- Cliquez "Commencer" sur la dernière slide

**Inscription**
1. Remplissez : Prénom, Nom, Téléphone, Mot de passe
2. Cliquez "S'inscrire"

**Connexion**
1. Téléphone : +237 600 000 000 (exemple)
2. Mot de passe : test123 (exemple)
3. Cliquez "Se connecter"

### 3. Navigation dans l'App

**Écran d'accueil**
- Carte d'urgence rouge (accès rapide QR Code)
- 4 actions principales : QR Code, Rappels, Documents, Famille
- Rappels du jour affichés en bas
- FAB vert "Scanner" en bas à droite

**Bottom Navigation**
- 🏠 Accueil : Dashboard principal
- 📊 Statistiques : Suivi de santé
- 👤 Profil : Infos personnelles

**Menu latéral (☰)**
- Mon QR Code
- Rappels
- Documents
- Ma Famille
- Paramètres
- Déconnexion

### 4. Fonctionnalités Principales

**QR Code**
- Cliquez sur "Mon QR Code" (accueil ou menu)
- Votre QR personnel s'affiche
- Boutons Partager / Télécharger
- Infos d'urgence visibles

**Scanner**
- Cliquez sur le FAB vert "Scanner"
- Simulation de scan (2 secondes)
- Modal avec infos patient scannées
- Boutons "Scanner à nouveau" ou "OK"

**Rappels**
- Liste des rappels actifs
- Bouton + pour créer
- Formulaire : Titre, Dosage, Heure, Fréquence
- Switch pour activer/désactiver

**Documents**
- Liste avec icônes par type
- Bouton + pour uploader
- 3 options : Caméra, Galerie, Fichier
- Types : Analyse, Imagerie, Prescription, Vaccination

**Famille**
- Liste des membres
- Bouton + pour ajouter
- Relations : Époux/Épouse, Enfant, Parent, Frère/Sœur

**Profil Médical**
- Accès via Profil > Informations personnelles
- Édition complète
- Photo (placeholder)
- Données médicales
- Contact d'urgence
- Bouton "Enregistrer"

**Statistiques**
- Observance des traitements (%)
- Documents uploadés
- Consultations
- Graphiques de progression
- Activité récente

---

## 🎨 Design Features

### Animations Implémentées
✅ Splash avec pulse et cercles
✅ Transitions Fade entre écrans
✅ Transitions Slide pour les modales
✅ Cards avec effet de pression (scale)
✅ Shimmer loading
✅ Slide + Fade pour les éléments
✅ Pulse sur le QR Code
✅ Gradient animés

### Thème Visuel
- **Couleurs** : Bleu (#2196F3), Vert, Orange, Rouge, Violet
- **Gradients** : Dégradés fluides sur cartes et boutons
- **Ombres** : Ombres douces pour profondeur
- **Bordures** : Arrondis de 12-20px
- **Typographie** : Google Fonts Poppins
- **Icons** : Material Design avec gradients

### Expérience Utilisateur
- Navigation fluide et intuitive
- Feedback visuel sur toutes les actions
- Loading states partout
- Messages d'erreur clairs
- Confirmations pour actions critiques

---

## 🔧 Mode Développeur

### Backend Local
```dart
// lib/app/config.dart
static const String apiBaseUrl = 'http://10.0.2.2:8000/api/v1';
```

### Tests sans Backend
L'app fonctionne 100% en mode simulé :
- Connexion : n'importe quel téléphone/mdp
- Données : exemples prédéfinis
- Uploads : simulés (2s delay)
- Scanner : simulation automatique

### Activer le Backend
1. Déployez le backend Django
2. Modifiez `apiBaseUrl` dans `config.dart`
3. Recompilez l'APK
4. Les providers Riverpod se connectent automatiquement

---

## 📊 Statistiques App

- **Écrans** : 20+
- **Animations** : 10+ types
- **Widgets custom** : 15+
- **Routes** : 15
- **Taille APK** : ~80 MB
- **Performance** : 60 FPS
- **Support** : Android 5.0+

---

## 🐛 Dépannage

**L'app ne s'installe pas**
- Activez "Sources inconnues" dans les paramètres Android
- Vérifiez l'espace de stockage (min 100 MB)

**Animations saccadées**
- Normal sur émulateur
- Fluide sur appareil réel

**Backend ne répond pas**
- Vérifiez l'URL dans `config.dart`
- Testez l'endpoint `/health-check/`
- Vérifiez CORS sur Django

---

## 📞 Support

**GitHub** : github.com/ebongue12/mboka_care_mobile
**Issues** : Ouvrez un ticket sur GitHub
**Email** : guillaumembouma9@gmail.com

---

✨ **Profitez de MBOKA-CARE !** ✨
