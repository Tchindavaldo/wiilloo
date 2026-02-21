# Configuration Firebase pour WIILLOO

## 🚀 Étapes de Configuration

### 1. Créer un projet Firebase
1. Allez sur [Firebase Console](https://console.firebase.google.com/)
2. Cliquez sur "Ajouter un projet"
3. Nommez votre projet "WIILLOO"
4. Activez Google Analytics (recommandé)
5. Cliquez sur "Créer un projet"

### 2. Configurer Firebase pour Android
1. Dans la console Firebase, cliquez sur l'icône Android
2. Package name : `com.example.wiilloo`
3. Téléchargez `google-services.json`
4. Placez-le dans `android/app/google-services.json`
5. Ajoutez les dépendances dans `android/build.gradle` :
   ```gradle
   buildscript {
     dependencies {
       classpath 'com.google.gms:google-services:4.3.15'
     }
   }
   ```
6. Ajoutez dans `android/app/build.gradle` :
   ```gradle
   apply plugin: 'com.google.gms.google-services'
   ```

### 3. Configurer Firebase pour iOS
1. Dans la console Firebase, cliquez sur l'icône iOS
2. Bundle ID : `com.example.wiilloo`
3. Téléchargez `GoogleService-Info.plist`
4. Placez-le dans `ios/Runner/GoogleService-Info.plist`
5. Ajoutez dans `ios/Runner/AppDelegate.swift` :
   ```swift
   import Firebase
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     FirebaseApp.configure()
     return true
   }
   ```

### 4. Activer les services Firebase

#### Authentication
1. Allez dans "Authentication" > "Méthodes de connexion"
2. Activez "Email/Mot de passe"
3. Activez "Google" (configurez l'OAuth2)

#### Cloud Firestore
1. Allez dans "Firestore Database"
2. Créez une nouvelle base de données
3. Choisissez "Commencer en mode test"
4. Sélectionnez la localisation la plus proche

#### Firebase Storage
1. Allez dans "Storage"
2. Commencez en mode test
3. Configurez les règles de sécurité

### 5. Installer les dépendances
```bash
flutter pub get
```

### 6. Exécuter l'application
```bash
flutter run
```

## 🔧 Fonctionnalités Implémentées

### ✅ Authentification
- **Email/Password** : Inscription et connexion classique
- **Google Sign-In** : Connexion avec compte Google
- **Vérification email** : Email de confirmation envoyé
- **Mot de passe oublié** : Réinitialisation par email
- **Gestion des erreurs** : Messages d'erreur conviviaux

### 📊 Structure des données Firestore
```
users/{userId}
├── email: string
├── displayName: string
├── photoURL: string (optionnel)
├── emailVerified: boolean
├── createdAt: timestamp
├── favorites: array (epreuveIds)
└── lastLogin: timestamp

epreuves/{epreuveId}
├── title: string
├── subject: string
├── level: string
├── duration: string
├── questions: number
├── pdfUrl: string
├── correctionUrl: string
├── hasCorrection: boolean
├── university: string
├── class: string
├── year: string
├── downloads: number
├── rating: number
├── createdBy: string (userId)
├── createdAt: timestamp
└── updatedAt: timestamp

corrections/{correctionId}
├── epreuveId: string
├── userId: string
├── iaResponse: string
├── score: number
├── feedback: string
├── correctedAt: timestamp
└── status: string ('pending', 'completed')
```

### 🗂️ Structure Storage
```
epreuves/
├── {epreuveId}/
│   ├── original.pdf
│   └── correction.pdf
├── users/
│   └── {userId}/
│       └── profile.jpg
```

## 🛡️ Règles de Sécurité

### Firestore Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own profile
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Anyone can read epreuves
    match /epreuves/{epreuveId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
    
    // Users can read/write their own corrections
    match /corrections/{correctionId} {
      allow read, write: if request.auth != null && 
        resource.data.userId == request.auth.uid;
    }
  }
}
```

### Storage Rules
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Users can upload/read their own files
    match /users/{userId}/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Anyone can read epreuves
    match /epreuves/{epreuveId}/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

## 🎯 Prochaines Étapes

1. **Tester l'authentification** : Créer un compte, se connecter
2. **Implémenter l'upload d'épreuves** : Formulaire avec upload PDF
3. **Développer les corrections IA** : Intégration avec OpenAI/Vertex AI
4. **Ajouter les notifications** : Firebase Cloud Messaging
5. **Optimiser les performances** : Cache, pagination, etc.

## 🐛 Dépannage

### Erreurs communes
- **"Missing plugin"** : Exécutez `flutter clean` puis `flutter pub get`
- **"Google Sign-In failed"** : Vérifiez la configuration OAuth2
- **"Firestore permission denied"** : Vérifiez les règles de sécurité
- **"Storage permission denied"** : Vérifiez les règles Storage

### Debug
- Activez le debug mode dans Firebase Console
- Utilisez `FirebaseAuthException` pour voir les erreurs détaillées
- Vérifiez la console Firebase pour les logs
