# 🎓 Wiilloo - Platform d'Excellence Académique

> **Une application mobile Flutter révolutionnaire pour la gestion complète des évaluations académiques avec IA intégrée**

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Flutter](https://img.shields.io/badge/Flutter-3.8.1+-green.svg)
![License](https://img.shields.io/badge/license-Private-red.svg)
![Status](https://img.shields.io/badge/status-Production%20Ready-brightgreen.svg)

---

## 📋 Table des Matières

- [Vue d'ensemble](#vue-densemble)
- [Caractéristiques principales](#caractéristiques-principales)
- [Architecture du projet](#architecture-du-projet)
- [Installation et configuration](#installation-et-configuration)
- [Flux d'authentification](#flux-dauthentification)
- [Intégration backend](#intégration-backend)
- [Structure des dossiers](#structure-des-dossiers)
- [Technologies utilisées](#technologies-utilisées)
- [Guide de développement](#guide-de-développement)
- [Déploiement](#déploiement)
- [Troubleshooting](#troubleshooting)

---

## 🎯 Vue d'ensemble

**Wiilloo** est une plateforme académique complète conçue pour révolutionner la gestion des évaluations dans les établissements éducatifs. L'application offre une expérience utilisateur fluide et intuitive avec des fonctionnalités avancées alimentées par l'intelligence artificielle.

### 🎁 Propositions de valeur

- **📱 Mobile-First** : Application native Flutter pour iOS et Android
- **🤖 IA Intégrée** : Correction automatique et analyse intelligente des évaluations
- **📊 Analyses Avancées** : Insights détaillés sur la performance des étudiants
- **🔄 Collaboration** : Travail d'équipe fluide et synchronisé en temps réel
- **🔒 Sécurité Enterprise** : Conformité RGPD et protection des données
- **⚡ Performance** : Synchronisation en temps réel avec Socket.IO
- **🎨 Design Moderne** : Interface utilisateur élégante et responsive

---

## ✨ Caractéristiques principales

### 🏫 Gestion Complète
- Administration centralisée des établissements
- Gestion des utilisateurs et des rôles
- Configuration des politiques institutionnelles
- Suivi de la conformité et des standards

### ✏️ Création Intuitive
- Création facile des évaluations et des tests
- Éditeur de questions avancé
- Modèles réutilisables
- Support de multiples formats de questions

### 🤖 Intelligence Artificielle
- Correction automatique des réponses
- Analyse du contenu des réponses
- Suggestions d'amélioration
- Détection des patterns d'apprentissage

### 📊 Analyses & Insights
- Tableaux de bord interactifs
- Statistiques détaillées par classe/étudiant
- Rapports générés automatiquement
- Visualisations de données avancées

### 👥 Collaboration Fluide
- Partage de ressources entre enseignants
- Commentaires et annotations en temps réel
- Notifications instantanées
- Historique des modifications

### 🔒 Sécurité & Conformité
- Authentification multi-facteurs
- Chiffrement des données sensibles
- Audit trail complet
- Conformité RGPD

### 🔗 Intégration Système
- Connexion avec les systèmes d'information scolaires
- Import/Export de données
- API REST complète
- Webhooks pour les intégrations tierces

### 🚀 Prêt à Commencer
- Onboarding guidé
- Documentation intégrée
- Support utilisateur
- Tutoriels interactifs

---

## 🏗️ Architecture du projet

### Architecture Générale

Wiilloo suit une architecture **modulaire et scalable** basée sur les principes SOLID:

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                        │
│  (Screens, Widgets, UI Components, State Management)        │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                    Business Logic Layer                      │
│  (Providers Riverpod, StateNotifiers, Use Cases)            │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                    Data Layer                                │
│  (Repositories, Models, Services, Adapters)                 │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                    External Services                         │
│  (API REST, Socket.IO, Firebase, Local Storage)             │
└─────────────────────────────────────────────────────────────┘
```

### Principes Architecturaux

- **Séparation des responsabilités** : Chaque couche a une responsabilité unique
- **Modularité** : Chaque feature est indépendante et réutilisable
- **Testabilité** : Architecture favorisant les tests unitaires et d'intégration
- **Scalabilité** : Facile d'ajouter de nouvelles features sans impacter l'existant
- **Maintenabilité** : Code lisible et bien documenté

---

## 📦 Installation et configuration

### Prérequis

- **Flutter SDK** : Version 3.8.1 ou supérieure
- **Dart SDK** : Version 3.8.1 ou supérieure
- **Android Studio** ou **Xcode** (pour les émulateurs)
- **Git** : Pour le contrôle de version

### Installation locale

#### 1. Cloner le repository

```bash
git clone https://github.com/rudavo/wiilloo-frontend.git
cd wiilloo-frontend/wiilloo
```

#### 2. Installer les dépendances Flutter

```bash
flutter pub get
```

#### 3. Générer les fichiers Freezed et JSON

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

#### 4. Configurer les variables d'environnement

**`.env.development`** (pour le développement local)
```env
API_BASE_URL=http://192.168.8.101:3000
SOCKET_URL=http://192.168.8.101:3000
ENVIRONMENT=development
```

**`.env.production`** (pour la production)
```env
API_BASE_URL=https://api.wiilloo.com
SOCKET_URL=https://api.wiilloo.com
ENVIRONMENT=production
```

#### 5. Lancer l'application

```bash
flutter run
```

---

## 🔐 Flux d'authentification v3.3

### Vue d'ensemble

L'authentification suit un flux ultra-simplifié et optimisé :

```
AuthScreenV3 (Page d'accueil)
    ↓
[3 Boutons de Connexion]
├── 🌐 Google
├── 🍎 Apple
└── 💬 WhatsApp
    ↓
Présentation Fusionnée (8 étapes)
├── 🏫 Gestion Complète
├── ✏️ Création Intuitive
├── 🤖 Intelligence Artificielle
├── 📊 Analyses & Insights
├── 👥 Collaboration Fluide
├── 🔒 Sécurité & Conformité
├── 🔗 Intégration Système
└── 🚀 Prêt à Commencer
    ↓
OnboardingSuccess (Confirmation)
    ↓
MainDashboard (Accueil)
```

### Fichiers clés

| Fichier | Responsabilité |
|---------|----------------|
| `auth_screen_v3.dart` | Écran de connexion principal |
| `stepper_institutional.dart` | Présentation fusionnée (8 étapes) |
| `onboarding_success.dart` | Écran de confirmation |
| `main.dart` | Point d'entrée |

---

## 🔌 Intégration backend

### Configuration de l'API

L'application communique avec un backend Node.js/Express via une API REST et Socket.IO.

#### Endpoints principaux

```
GET  /api/epreuves                    # Récupérer les épreuves
GET  /api/epreuves/:id                # Détails d'une épreuve
POST /api/epreuves                    # Créer une épreuve
PUT  /api/epreuves/:id                # Mettre à jour une épreuve
DELETE /api/epreuves/:id              # Supprimer une épreuve
```

#### Paramètres de requête

```
GET /api/epreuves?cursor=0&groupBy=schoolName&itemsPerGroup=4&groupsLimit=18

- cursor: Position de pagination (par défaut: 0)
- groupBy: Critère de groupage (schoolName, matiere, niveau, etc.)
- itemsPerGroup: Nombre d'items par groupe (par défaut: 4)
- groupsLimit: Nombre de groupes à retourner (par défaut: 18)
```

### Socket.IO - Événements en temps réel

```dart
'epreuve:created'    // Nouvelle épreuve créée
'epreuve:updated'    // Épreuve mise à jour
'epreuve:deleted'    // Épreuve supprimée
'correction:added'   // Nouvelle correction ajoutée
'correction:updated' // Correction mise à jour
```

### Gestion d'état avec Riverpod

```dart
// Accéder à l'état des épreuves
final state = ref.watch(epreuveNotifierProvider);

// Charger les épreuves
ref.read(epreuveNotifierProvider.notifier).loadEpreuves();

// Charger plus (infinite scroll)
ref.read(epreuveNotifierProvider.notifier).loadMoreEpreuves();

// Rafraîchir les données
ref.read(epreuveNotifierProvider.notifier).refreshEpreuves();

// Créer une épreuve
ref.read(epreuveNotifierProvider.notifier).createEpreuve(data);
```

---

## 📁 Structure des dossiers

```
wiilloo/
├── lib/
│   ├── core/                          # Fonctionnalités transversales
│   │   ├── config/
│   │   │   └── environment_config.dart
│   │   ├── constants/
│   │   ├── extensions/
│   │   └── utils/
│   │
│   ├── features/                      # Features métier
│   │   ├── auth/                      # Authentification
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   ├── services/
│   │   │   │   └── repositories/
│   │   │   └── presentation/
│   │   │       ├── screens/
│   │   │       ├── widgets/
│   │   │       └── providers/
│   │   │
│   │   ├── home/                      # Accueil
│   │   ├── epreuves/                  # Gestion des épreuves
│   │   ├── corrections/               # Gestion des corrections
│   │   ├── analytics/                 # Analyses et statistiques
│   │   └── profile/                   # Profil utilisateur
│   │
│   ├── shared/                        # Code partagé
│   │   ├── widgets/
│   │   ├── services/
│   │   └── models/
│   │
│   └── main.dart                      # Point d'entrée
│
├── android/                           # Configuration Android
├── ios/                               # Configuration iOS
├── assets/                            # Ressources
├── design/                            # Fichiers de design
├── test/                              # Tests unitaires
│
├── pubspec.yaml                       # Dépendances Flutter
├── pubspec.lock                       # Versions verrouillées
├── analysis_options.yaml              # Configuration linter
├── .env.development                   # Variables d'environnement (dev)
├── .env.production                    # Variables d'environnement (prod)
│
├── AUTH_FLOW.md                       # Documentation du flux d'auth
├── BACKEND_INTEGRATION.md             # Guide d'intégration backend
├── FLUX_RESUME.md                     # Résumé du flux
└── LAUNCH_DEVICES.md                  # Guide de lancement
```

---

## 🛠️ Technologies utilisées

### Framework & Language
- **Flutter** 3.8.1+ - Framework UI multi-plateforme
- **Dart** 3.8.1+ - Langage de programmation

### State Management
- **flutter_riverpod** 2.5.1 - Gestion d'état réactive
- **freezed** 2.4.7 - Génération de classes immuables

### API & Networking
- **http** 1.2.0 - Client HTTP
- **socket_io_client** 2.0.3+1 - Communication en temps réel

### Sérialisation
- **json_annotation** 4.8.1 - Annotations JSON
- **json_serializable** 6.7.1 - Génération de sérialiseurs

### Authentification
- **firebase_auth** 5.3.1 - Authentification Firebase
- **google_sign_in** 6.2.1 - Authentification Google
- **firebase_core** 3.6.0 - Core Firebase

### Stockage
- **shared_preferences** 2.3.2 - Stockage local persistant

### Utilitaires
- **google_fonts** 6.2.1 - Polices Google
- **cupertino_icons** 1.0.8 - Icônes iOS
- **flutter_dotenv** 5.1.0 - Gestion des variables d'environnement
- **equatable** 2.0.5 - Comparaison d'objets
- **file_picker** 8.0.0+1 - Sélection de fichiers

### Développement
- **flutter_lints** 5.0.0 - Linter Flutter
- **build_runner** 2.4.8 - Générateur de code
- **flutter_test** - Framework de test

---

## 📚 Guide de développement

### Conventions de code

#### Nommage des fichiers
- **Screens** : `snake_case.dart` (ex: `home_screen.dart`)
- **Widgets** : `snake_case.dart` (ex: `custom_button.dart`)
- **Models** : `snake_case.dart` (ex: `user_model.dart`)
- **Services** : `snake_case_service.dart` (ex: `api_service.dart`)

#### Nommage des classes
- **Screens** : `PascalCase` + `Screen` (ex: `HomeScreen`)
- **Widgets** : `PascalCase` + `Widget` (ex: `CustomButton`)
- **Models** : `PascalCase` (ex: `UserModel`)
- **Services** : `PascalCase` + `Service` (ex: `ApiService`)

#### Imports
```dart
// 1. Imports dart
import 'dart:async';
import 'dart:convert';

// 2. Imports Flutter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 3. Imports packages
import 'package:http/http.dart' as http;

// 4. Imports relatifs
import '../models/user_model.dart';
```

### Créer une nouvelle feature

#### Structure de dossiers
```
lib/features/ma_feature/
├── data/
│   ├── models/
│   ├── services/
│   └── repositories/
└── presentation/
    ├── screens/
    ├── widgets/
    └── providers/
```

#### Générer les fichiers Freezed

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Ou en mode watch :

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Tests

#### Exécuter les tests
```bash
flutter test
```

---

## 🚀 Déploiement

### Préparation au déploiement

```bash
# Vérifier la version dans pubspec.yaml
version: 1.0.0+1

# Générer les fichiers de build
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

# Analyser le code
flutter analyze

# Exécuter les tests
flutter test
```

### Déploiement Android

```bash
# Générer l'APK
flutter build apk --release

# Générer l'AAB (pour Google Play)
flutter build appbundle --release
```

### Déploiement iOS

```bash
# Générer l'IPA
flutter build ipa --release
```

---

## 🔧 Troubleshooting

### Problèmes courants

#### Erreur : "No such file or directory: '.env.development'"
**Solution :** Assurez-vous que les fichiers `.env` existent à la racine du projet wiilloo.

#### Erreur : "Failed to connect to backend"
**Solution :** Vérifiez que le backend est lancé et l'adresse IP dans `.env` est correcte.

#### Erreur : "Freezed files not generated"
**Solution :** Régénérez les fichiers :
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

#### Erreur : "Socket.IO connection failed"
**Solution :** Vérifiez que le serveur Socket.IO est lancé et l'URL est correcte.

#### Erreur : "Google Sign-In failed"
**Solution :** Vérifiez que les clés Google sont configurées dans Firebase.

### Logs et débogage

```bash
# Afficher les logs
flutter logs

# Logs avec filtrage
flutter logs -f "wiilloo"

# Débogage en mode verbose
flutter run -v
```

---

## 📞 Support et ressources

### Documentation officielle
- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Riverpod Documentation](https://riverpod.dev)
- [Firebase Documentation](https://firebase.google.com/docs)

### Fichiers de documentation du projet
- `AUTH_FLOW.md` - Flux d'authentification détaillé
- `BACKEND_INTEGRATION.md` - Guide d'intégration backend
- `FLUX_RESUME.md` - Résumé du flux d'authentification v3.3
- `LAUNCH_DEVICES.md` - Guide de lancement sur différents appareils

### Contacts
- **Email** : support@wiilloo.com
- **Issues** : GitHub Issues
- **Discussions** : GitHub Discussions

---

## 📄 Licence

Ce projet est privé et propriétaire. Tous les droits sont réservés.

---

## 🙏 Remerciements

Merci à tous les contributeurs et à la communauté Flutter pour leur soutien !

---

**Dernière mise à jour** : Décembre 2024  
**Version** : 1.0.0  
**Status** : Production Ready ✅
