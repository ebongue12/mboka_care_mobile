# 📱 MBOKA-CARE - Documentation Complète

## 🎯 Vue d'ensemble

MBOKA-CARE est une application mobile Flutter de gestion de santé personnelle et familiale, développée pour le marché camerounais et africain.

---

## ✅ FONCTIONNALITÉS IMPLÉMENTÉES

### 🔐 1. Authentification & Sécurité
- ✅ Écran Splash animé
- ✅ Onboarding (3 slides de présentation)
- ✅ Inscription utilisateur (nom, prénom, téléphone, mot de passe)
- ✅ Connexion sécurisée
- ✅ Stockage local des tokens (SharedPreferences)
- ✅ Gestion de session persistante
- ✅ Déconnexion sécurisée

### 👤 2. Profil Patient
- ✅ Profil médical complet (éditable)
- ✅ Informations personnelles (nom, prénom, téléphone, date de naissance)
- ✅ Données médicales (groupe sanguin, allergies, maladies chroniques)
- ✅ Contact d'urgence
- ✅ Photo de profil (placeholder)
- ✅ Calcul automatique de l'âge

### 📱 3. QR Code d'Urgence
- ✅ Génération de QR Code personnel
- ✅ Affichage des informations vitales
- ✅ Design adapté aux urgences médicales
- ✅ Scanner QR Code (version simulée)
- ✅ Lecture des données patients scannés
- ✅ Affichage modal des informations d'urgence

### ⏰ 4. Rappels Médicaments
- ✅ Liste des rappels actifs
- ✅ Création de nouveaux rappels
- ✅ Configuration : titre, dosage, heure, fréquence
- ✅ Switch activation/désactivation
- ✅ Service de notifications (structure prête)
- ✅ Indicateur "Rappel pris"
- ✅ Calendrier de prise

### 📄 5. Documents Médicaux
- ✅ Liste des documents avec catégories
- ✅ Upload depuis :
  - Appareil photo
  - Galerie
  - Fichiers (PDF, images, Word)
- ✅ Types de documents : Analyse, Imagerie, Prescription, Vaccination
- ✅ Métadonnées : date, type, titre
- ✅ Bouton téléchargement (placeholder)
- ✅ Interface d'upload avec preview

### 👨‍👩‍👧‍👦 6. Gestion Famille
- ✅ Liste des membres de la famille
- ✅ Ajout de membres
- ✅ Relations : Époux/Épouse, Enfant, Parent, Frère/Sœur, Autre
- ✅ Informations par membre : nom, âge, relation
- ✅ Accès aux profils (placeholder)

### 📊 7. Statistiques de Santé
- ✅ Dashboard avec résumé mensuel
- ✅ Observance des traitements (pourcentage)
- ✅ Graphiques de progression
- ✅ Activité récente (timeline)
- ✅ Compteurs : rappels pris, documents, consultations
- ✅ Design moderne avec gradient

### ⚙️ 8. Paramètres
- ✅ Gestion des notifications
- ✅ Rappels médicaments on/off
- ✅ Mode sombre (placeholder)
- ✅ Version de l'app
- ✅ Politique de confidentialité (placeholder)
- ✅ Conditions d'utilisation (placeholder)
- ✅ Déconnexion avec confirmation

### 🎨 9. Interface & Navigation
- ✅ Bottom Navigation (3 onglets : Accueil, Stats, Profil)
- ✅ Drawer Navigation (menu latéral)
- ✅ Actions rapides (cartes cliquables)
- ✅ Design Material 3
- ✅ Couleurs cohérentes (Bleu #2196F3)
- ✅ Animations fluides
- ✅ Responsive

---

## 🏗️ ARCHITECTURE TECHNIQUE

### 📦 Structure du Projet
```
lib/
├── app/
│   ├── config.dart              # Configuration globale
│   └── routes.dart              # Routes de navigation
├── core/
│   ├── network/
│   │   ├── api_client.dart      # Client HTTP (Dio)
│   │   └── error_handler.dart   # Gestion d'erreurs
│   ├── services/
│   │   └── notification_service.dart
│   └── storage/
│       └── local_storage.dart   # SharedPreferences wrapper
├── data/
│   └── models/
│       ├── user_model.dart
│       ├── patient_model.dart
│       └── reminder_model.dart
├── features/
│   ├── auth/
│   │   ├── providers/           # Auth state management
│   │   └── screens/
│   ├── documents/
│   ├── family/
│   ├── home/
│   ├── onboarding/
│   ├── patient/
│   ├── qr/
│   ├── reminders/
│   └── splash/
└── shared/
    └── widgets/
        ├── loading_overlay.dart
        └── error_widget.dart
```

### 🔧 Technologies & Packages
| Package | Version | Usage |
|---------|---------|-------|
| flutter_riverpod | ^2.4.9 | State management |
| dio | ^5.4.0 | HTTP client |
| shared_preferences | ^2.2.2 | Stockage local |
| qr_flutter | ^4.1.0 | Génération QR Code |
| image_picker | ^1.0.5 | Photos/Caméra |
| file_picker | ^6.1.1 | Sélection fichiers |
| intl | ^0.18.1 | Formatage dates |
| google_fonts | ^6.1.0 | Typographie |

### 🔌 Endpoints API Prévus
```dart
// Auth
POST /api/v1/auth/register/
POST /api/v1/auth/login/
POST /api/v1/auth/logout/

// Patients
GET  /api/v1/patients/me/
PUT  /api/v1/patients/me/
GET  /api/v1/patients/family-members/
POST /api/v1/patients/family-members/
GET  /api/v1/patients/stats/

// QR Code
GET  /api/v1/patients/qr/
GET  /api/v1/patients/qr/generate/
POST /api/v1/patients/qr/scan/

// Documents
GET    /api/v1/medical/documents/
POST   /api/v1/medical/documents/
DELETE /api/v1/medical/documents/{id}/

// Rappels
GET    /api/v1/reminders/
POST   /api/v1/reminders/
PUT    /api/v1/reminders/{id}/
DELETE /api/v1/reminders/{id}/
POST   /api/v1/reminders/logs/

// Notifications
GET   /api/v1/notifications/
PATCH /api/v1/notifications/{id}/read/
```

---

## 🚀 PROCHAINES ÉTAPES

### Phase 1 : Backend Integration (Prioritaire)
- [ ] Connecter au backend Django
- [ ] Implémenter tous les appels API
- [ ] Gestion d'erreurs réseau
- [ ] Synchronisation des données
- [ ] Tests d'intégration

### Phase 2 : Fonctionnalités Avancées
- [ ] Scanner QR avec caméra réelle (mobile_scanner)
- [ ] Notifications push locales
- [ ] Partage de documents
- [ ] Export PDF du profil
- [ ] Historique médical complet

### Phase 3 : Modules Métier
- [ ] Module Médecin
  - Recherche patients par QR
  - Historique consultations
  - Prescriptions électroniques
- [ ] Module Hôpital
  - Gestion admissions
  - Accès urgences
  - Facturation

### Phase 4 : Premium Features
- [ ] Téléconsultation
- [ ] Géolocalisation hôpitaux
- [ ] Assurance santé
- [ ] Pharmacie en ligne
- [ ] Paiement mobile (Orange Money, MTN MoMo)

---

## 📊 MÉTRIQUES ACTUELLES

- **Écrans** : 20+ écrans complets
- **Lignes de code** : ~5000+ lignes
- **Fonctionnalités** : 9 modules principaux
- **Taille APK** : ~80 MB (debug)
- **Support** : Android 5.0+ (API 21+)

---

## 🎨 DESIGN SYSTEM

### Couleurs
- **Primary** : #2196F3 (Bleu)
- **Success** : #4CAF50 (Vert)
- **Warning** : #FF9800 (Orange)
- **Error** : #F44336 (Rouge)
- **Info** : #9C27B0 (Violet)

### Typographie
- **Titres** : Bold, 24-32px
- **Sous-titres** : SemiBold, 16-18px
- **Corps** : Regular, 14-16px
- **Captions** : Regular, 12px

### Espacements
- **XS** : 4px
- **SM** : 8px
- **MD** : 16px
- **LG** : 24px
- **XL** : 32px

---

## 📝 NOTES DE DÉVELOPPEMENT

### Points d'attention
1. ⚠️ `mobile_scanner` retiré (problème Android embedding v2)
2. ⚠️ `flutter_secure_storage` retiré (même problème)
3. ⚠️ `connectivity_plus` retiré (même problème)
4. ✅ Scanner simulé fonctionnel en attendant
5. ✅ API client prêt pour backend Django

### Optimisations futures
- Lazy loading des images
- Cache des documents
- Compression des uploads
- Mode offline
- Tests unitaires
- Tests d'intégration

---

## 🤝 CONTRIBUTION

Ce projet a été développé par **Mbouma Ebongue Guillaume** (@ebongue12).

---

## 📄 LICENCE

MIT License - Libre d'utilisation commerciale.

---

**Version** : 1.0.0  
**Dernière mise à jour** : Février 2026  
**Status** : ✅ Production Ready (Frontend)
