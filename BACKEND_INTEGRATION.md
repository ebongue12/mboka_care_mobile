# 🔌 Guide d'Intégration Backend Django

## 📋 Prérequis Backend

Votre API Django doit exposer les endpoints suivants :

### Base URL
```
https://votre-backend.replit.dev/api/v1
```

### Headers Requis
```
Content-Type: application/json
Accept: application/json
Authorization: Bearer {access_token}
```

---

## 🔐 1. Authentication Endpoints

### Register
```http
POST /auth/register/
Content-Type: application/json

{
  "phone": "+237600000000",
  "password": "securepass123",
  "first_name": "Jean",
  "last_name": "DUPONT"
}

Response 201:
{
  "user": {
    "id": "uuid",
    "phone": "+237600000000",
    "role": "patient"
  },
  "access": "eyJ0eXAiOiJKV1QiLCJh...",
  "refresh": "eyJ0eXAiOiJKV1QiLCJh..."
}
```

### Login
```http
POST /auth/login/
Content-Type: application/json

{
  "phone": "+237600000000",
  "password": "securepass123"
}

Response 200:
{
  "user": {
    "id": "uuid",
    "phone": "+237600000000",
    "email": "user@example.com",
    "role": "patient"
  },
  "access": "eyJ0eXAiOiJKV1QiLCJh...",
  "refresh": "eyJ0eXAiOiJKV1QiLCJh..."
}
```

### Logout
```http
POST /auth/logout/
Authorization: Bearer {access_token}

Response 204: No Content
```

---

## 👤 2. Patient Endpoints

### Get Profile
```http
GET /patients/me/
Authorization: Bearer {access_token}

Response 200:
{
  "id": "uuid",
  "first_name": "Jean",
  "last_name": "DUPONT",
  "date_of_birth": "1990-01-01",
  "blood_group": "O+",
  "allergies": "Pénicilline",
  "chronic_conditions": "Diabète type 2",
  "emergency_contact_name": "Marie DUPONT",
  "emergency_contact_phone": "+237677888999"
}
```

### Update Profile
```http
PUT /patients/me/
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "first_name": "Jean",
  "blood_group": "O+",
  "allergies": "Pénicilline, Arachides"
}

Response 200: {updated_profile}
```

---

## 📱 3. QR Code Endpoints

### Get Patient QR
```http
GET /patients/qr/
Authorization: Bearer {access_token}

Response 200:
{
  "qr_code_data": "{encrypted_patient_data}",
  "expires_at": "2026-03-01T00:00:00Z"
}
```

### Generate New QR
```http
GET /patients/qr/generate/
Authorization: Bearer {access_token}

Response 200:
{
  "qr_code_data": "{new_encrypted_data}",
  "expires_at": "2026-03-01T00:00:00Z"
}
```

### Scan QR (For Emergency)
```http
POST /patients/qr/scan/
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "qr_code_data": "{scanned_data}"
}

Response 200:
{
  "patient": {
    "first_name": "Jean",
    "last_name": "DUPONT",
    "age": 35,
    "blood_group": "O+",
    "allergies": "Pénicilline",
    "chronic_conditions": "Diabète",
    "emergency_contact_name": "Marie",
    "emergency_contact_phone": "+237677888999"
  }
}
```

---

## 📄 4. Documents Endpoints

### List Documents
```http
GET /medical/documents/
Authorization: Bearer {access_token}

Response 200:
{
  "results": [
    {
      "id": "uuid",
      "title": "Analyse de sang",
      "document_type": "analysis",
      "uploaded_at": "2026-02-15T10:30:00Z",
      "file_url": "https://...",
      "file_size": 1024000
    }
  ]
}
```

### Upload Document
```http
POST /medical/documents/
Authorization: Bearer {access_token}
Content-Type: multipart/form-data

file: [binary]
title: "Analyse de sang"
document_type: "analysis"

Response 201:
{
  "id": "uuid",
  "title": "Analyse de sang",
  "file_url": "https://..."
}
```

---

## ⏰ 5. Reminders Endpoints

### List Reminders
```http
GET /reminders/
Authorization: Bearer {access_token}

Response 200:
{
  "results": [
    {
      "id": "uuid",
      "title": "Paracétamol",
      "medication_name": "Paracétamol 500mg",
      "dosage": "500mg",
      "frequency": "daily",
      "time_slots": ["08:00", "20:00"],
      "is_active": true
    }
  ]
}
```

### Create Reminder
```http
POST /reminders/
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "title": "Paracétamol",
  "medication_name": "Paracétamol 500mg",
  "dosage": "500mg",
  "frequency": "daily",
  "time_slots": ["08:00", "20:00"]
}

Response 201: {created_reminder}
```

### Log Reminder Taken
```http
POST /reminders/logs/
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "reminder_id": "uuid",
  "taken_at": "2026-02-21T08:05:00Z",
  "notes": "Pris après petit déjeuner"
}

Response 201:
{
  "id": "uuid",
  "reminder_id": "uuid",
  "taken_at": "2026-02-21T08:05:00Z"
}
```

---

## 👨‍👩‍👧‍👦 6. Family Endpoints

### List Family Members
```http
GET /patients/family-members/
Authorization: Bearer {access_token}

Response 200:
{
  "results": [
    {
      "id": "uuid",
      "first_name": "Marie",
      "last_name": "DUPONT",
      "relation": "spouse",
      "date_of_birth": "1992-05-15",
      "phone": "+237677888999"
    }
  ]
}
```

### Add Family Member
```http
POST /patients/family-members/
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "first_name": "Marie",
  "last_name": "DUPONT",
  "relation": "spouse",
  "date_of_birth": "1992-05-15"
}

Response 201: {created_member}
```

---

## 📊 7. Statistics Endpoint
```http
GET /patients/stats/
Authorization: Bearer {access_token}

Response 200:
{
  "reminders": {
    "total": 30,
    "taken": 28,
    "missed": 2,
    "compliance_rate": 0.93
  },
  "documents": {
    "total": 12,
    "by_type": {
      "analysis": 5,
      "imaging": 3,
      "prescription": 4
    }
  },
  "consultations": 3
}
```

---

## 🔔 8. Notifications Endpoint
```http
GET /notifications/
Authorization: Bearer {access_token}

Response 200:
{
  "results": [
    {
      "id": "uuid",
      "title": "Rappel médicament",
      "message": "Il est temps de prendre votre Paracétamol",
      "is_read": false,
      "created_at": "2026-02-21T08:00:00Z"
    }
  ]
}
```

---

## ⚙️ Configuration Flutter

### 1. Modifier `lib/app/config.dart`
```dart
class AppConfig {
  // 🔥 CHANGEZ CETTE URL !
  static const String apiBaseUrl = 'https://votre-backend.replit.dev/api/v1';
  
  // Ou pour développement local :
  // static const String apiBaseUrl = 'http://10.0.2.2:8000/api/v1'; // Android Emulator
  // static const String apiBaseUrl = 'http://localhost:8000/api/v1'; // iOS Simulator
}
```

### 2. Tester la Connexion
```dart
// Dans n'importe quel screen
import '../../core/network/api_client.dart';

Future<void> testConnection() async {
  try {
    final response = await ApiClient().dio.get('/health-check/');
    print('✅ Backend accessible: ${response.data}');
  } catch (e) {
    print('❌ Erreur connexion: $e');
  }
}
```

---

## 🧪 Test des Endpoints

### Avec cURL
```bash
# Test Register
curl -X POST https://votre-backend.replit.dev/api/v1/auth/register/ \
  -H "Content-Type: application/json" \
  -d '{"phone":"+237600000000","password":"test123","first_name":"Test","last_name":"User"}'

# Test Login
curl -X POST https://votre-backend.replit.dev/api/v1/auth/login/ \
  -H "Content-Type: application/json" \
  -d '{"phone":"+237600000000","password":"test123"}'

# Test Protected Endpoint
curl https://votre-backend.replit.dev/api/v1/patients/me/ \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

---

## 🚨 Gestion d'Erreurs

Le client API gère automatiquement :
- ✅ Token expiré (401) → Déconnexion auto
- ✅ Timeout (30s)
- ✅ Erreurs réseau
- ✅ Messages d'erreur localisés

---

## 📝 Checklist Intégration

- [ ] Backend Django opérationnel
- [ ] Tous les endpoints disponibles
- [ ] CORS configuré pour Flutter
- [ ] JWT tokens fonctionnels
- [ ] URL backend configurée dans `config.dart`
- [ ] Test de connexion réussi
- [ ] Register/Login fonctionnel
- [ ] Providers Riverpod connectés
- [ ] Gestion d'erreurs testée
- [ ] Mode offline prévu

