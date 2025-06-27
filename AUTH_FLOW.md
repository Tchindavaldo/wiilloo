# Flux d'Authentification v3 - Documentation

## Vue d'ensemble

Ce document décrit le flux d'authentification v3 de l'application Wiilloo, qui comprend maintenant les steppers d'onboarding connectés pour une expérience utilisateur complète. Le LoginScreen a été supprimé pour simplifier le flux.

## Architecture du flux

### 1. Point d'entrée principal
- **`design_selector.dart`** - Sélecteur de design (HomePage)
  - Navigation vers AuthScreenV3

### 2. Écran d'authentification principal
- **`auth_screen_v3.dart`** - Interface d'authentification moderne
  - Options : Google Workspace et Apple Business
  - Modal de sélection du type de compte avec 3 options :
    - Bienvenue (WelcomeScreen)
    - Compte Institutionnel 
    - Compte Personnel
  - Navigation directe vers les steppers ou WelcomeScreen

### 3. Écran de bienvenue (optionnel)
- **`welcome_screen.dart`** - Écran de bienvenue intégré aux steppers
  - Modal de sélection du type de compte
  - Navigation vers les steppers appropriés

### 4. Steppers d'onboarding
- **`stepper_institutional.dart`** - Configuration institutionnelle
  - Informations de l'établissement
  - Politiques et conformité
  - Navigation vers stepper personnel

- **`stepper_personal.dart`** - Configuration personnelle
  - Profil utilisateur
  - Rôles et permissions
  - Navigation vers écran de succès

### 5. Finalisation
- **`onboarding_success.dart`** - Confirmation de configuration
  - Animation de succès
  - Auto-navigation vers dashboard
  - Navigation vers MainDashboard

## Flux de navigation détaillé

```
HomePage (design_selector.dart)
    ↓
AuthScreenV3 (auth_screen_v3.dart)
    ↓
[Modal de sélection : Bienvenue | Institutionnel | Personnel]
    ↓
┌─────────────────┬─────────────────────┬─────────────────────┐
│   Bienvenue     │  Compte             │  Compte             │
│      ↓          │  Institutionnel     │  Personnel          │
│ WelcomeScreen   │         ↓           │         ↓           │
│      ↓          │  StepperInstitutional│  StepperPersonal   │
│ [Modal sélection]│         ↓           │         ↓           │
│      ↓          │  StepperPersonal    │                     │
└──────┼─────────────────────┼─────────────────────┼───────────┘
       └─────────────────────┴─────────────────────┘
                              ↓
                    OnboardingSuccess (onboarding_success.dart)
                              ↓
                          MainDashboard
```

## Types de comptes

### Compte Institutionnel
- **Cible** : Écoles, universités, organisations éducatives
- **Données collectées** :
  - Nom de l'établissement
  - Type d'établissement
  - Taille de l'établissement
  - Contact principal
  - Domaine email
  - Politiques de données
  - Conformité sécuritaire

### Compte Personnel
- **Cible** : Éducateurs individuels, enseignants
- **Données collectées** :
  - Nom et prénom
  - Titre du poste
  - Département
  - Numéro de téléphone
  - Rôles sélectionnés
  - Matières enseignées
  - Permissions
  - Préférences de notification

## Animations et transitions

### AuthScreenV3
- Animation de slide et fade à l'initialisation
- Patterns géométriques animés en arrière-plan
- Transitions fluides entre les écrans

### LoginScreen
- Parallax scrolling
- Animations de scale et fade
- Modal bottom sheet pour sélection du type de compte

### Steppers
- **Institutional** : Progress bar animée, transitions slide
- **Personal** : Animations fade, gestion des étapes multiples

### OnboardingSuccess
- Animation élastique pour l'icône de succès
- Particules animées en arrière-plan
- Items de completion avec animations décalées
- Auto-navigation après 4 secondes

### Configuration requise

### Imports principaux
```dart
// Dans auth_screen_v3.dart
import 'stepper_institutional.dart';
import 'stepper_personal.dart';
import 'welcome_screen.dart';

// Dans welcome_screen.dart
import 'stepper_institutional.dart';
import 'stepper_personal.dart';

// Dans stepper_institutional.dart  
import 'stepper_personal.dart';

// Dans stepper_personal.dart
import 'onboarding_success.dart';
```

### Méthodes de navigation
- `_showUserTypeSelection()` - Modal de sélection (dans AuthScreenV3 et WelcomeScreen)
- `_navigateToWelcome()` - Navigation vers écran de bienvenue
- `_navigateToInstitutionalStepper()` - Navigation vers stepper institutionnel
- `_navigateToPersonalStepper()` - Navigation vers stepper personnel
- `_completeSetup()` - Finalisation dans chaque stepper

## États et données

### Stepper Institutionnel
```dart
String _institutionName = '';
String _institutionType = '';
String _institutionSize = '';
String _primaryContact = '';
String _emailDomain = '';
bool _hasDataPolicy = false;
bool _hasSecurityCompliance = false;
```

### Stepper Personnel
```dart
String _firstName = '';
String _lastName = '';
String _jobTitle = '';
String _department = '';
String _phoneNumber = '';
List<String> _selectedRoles = [];
List<String> _selectedSubjects = [];
Map<String, bool> _permissions = {};
bool _enableNotifications = true;
bool _enableAnalytics = true;
bool _enableReporting = false;
```

## Changements récents (v3.1)

### ✅ Corrections apportées :
- **Suppression de LoginScreen** : Flux simplifié, navigation directe depuis AuthScreenV3
- **Intégration de WelcomeScreen** : Ajouté comme option dans le flux des steppers
- **Correction d'erreurs** :
  - `Icons.business_outline` → `Icons.business`
  - `HapticFeedback.successNotification()` → `HapticFeedback.lightImpact()`

### 🔄 Nouveau flux :
1. **AuthScreenV3** → Modal de sélection (3 options)
2. **WelcomeScreen** → Modal de sélection (2 options)
3. **Steppers** → OnboardingSuccess → MainDashboard

## Prochaines étapes d'amélioration

1. **Intégration backend** : Connexion avec les services d'authentification réels
2. **Validation des données** : Validation robuste des formulaires
3. **Sauvegarde locale** : Persistence des données en cas d'interruption
4. **Tests** : Tests unitaires et d'intégration
5. **Accessibilité** : Support pour les technologies d'assistance
6. **Internationalization** : Support multilingue

## Notes techniques

- Utilise `TickerProviderStateMixin` pour les animations multiples
- Implémente `HapticFeedback` pour l'expérience tactile
- Transitions personnalisées avec `PageRouteBuilder`
- Animations coordonnées avec `AnimationController`
- Responsive design adaptatif
- **LoginScreen supprimé** pour simplifier l'architecture

---

*Dernière mise à jour : Décembre 2024*
*Version du flux : 3.1*