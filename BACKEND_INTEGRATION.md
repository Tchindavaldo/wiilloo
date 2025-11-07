# Intégration Backend - Wiilloo

## 🚀 Configuration Rapide

### 1. Variables d'environnement

Modifiez les URLs dans les fichiers `.env` :

**`.env.development`** (dev)
```env
API_BASE_URL=http://localhost:3000
SOCKET_URL=http://localhost:3000
```

**`.env.production`** (prod)
```env
API_BASE_URL=https://api.wiilloo.com
SOCKET_URL=https://api.wiilloo.com
```

### 2. Initialisation

Dans `main.dart`, changez `isProduction` selon l'environnement :
```dart
await EnvironmentConfig.initialize(isProduction: false); // false pour dev
```

## 📡 Endpoint Backend

```
GET /api/epreuves?cursor=0&groupBy=schoolName&itemsPerGroup=4&groupsLimit=18
```

## 🎯 Fonctionnalités Implémentées

✅ **Store Riverpod** - Gestion d'état modulaire  
✅ **Infinite Scroll** - Chargement automatique au scroll  
✅ **Socket.IO** - Mises à jour en temps réel  
✅ **CRUD complet** - Create, Read, Update, Delete  
✅ **Adaptateur de données** - Conversion backend → widgets existants  
✅ **Alternance de designs** - 3 styles de cartes qui alternent  

## 🔌 Socket.IO - Événements en temps réel

Le système écoute automatiquement ces événements :
- `epreuve:created` - Nouvelle épreuve
- `epreuve:updated` - Mise à jour épreuve
- `epreuve:deleted` - Suppression épreuve
- `correction:added` - Nouvelle correction
- `correction:updated` - Mise à jour correction

## 📂 Architecture

```
lib/
├── core/config/
│   └── environment_config.dart          # Config env
│
├── features/home/
│   ├── data/
│   │   ├── models/                      # Modèles Freezed
│   │   ├── services/                    # API + Socket.IO
│   │   ├── repositories/                # CRUD Repository
│   │   └── adapters/                    # Convertisseur données
│   │
│   └── presentation/
│       ├── screens/home_screen.dart     # ✅ Adapté avec Riverpod
│       ├── widgets/                     # Vos widgets existants
│       ├── providers/                   # Providers Riverpod
│       └── state/                       # StateNotifier + State
```

## 🎨 HomeScreen - Intégration

Le `home_screen.dart` a été adapté pour :

1. **Charger les données du backend** au démarrage
2. **Afficher la première section** en auto-slide avec les données backend
3. **Afficher les autres sections** avec alternance de styles (3 designs)
4. **Gérer l'infinite scroll** - chargement auto à 80% du scroll
5. **Rafraîchir** avec pull-to-refresh
6. **Recevoir les mises à jour** en temps réel via Socket.IO

## 🧪 Test

Pour tester avec votre backend :

1. Assurez-vous que le backend est lancé
2. Modifiez `API_BASE_URL` dans `.env.development`
3. Lancez l'app : `flutter run`

Le HomeScreen va automatiquement :
- Se connecter au backend
- Charger les épreuves groupées par école
- Afficher en auto-slide la première section
- Alterner les designs pour les sections suivantes
- Charger plus de données au scroll

## 💡 Utilisation des Providers

```dart
// Accéder à l'état
final state = ref.watch(epreuveNotifierProvider);

// Charger les épreuves
ref.read(epreuveNotifierProvider.notifier).loadEpreuves();

// Charger plus (infinite scroll)
ref.read(epreuveNotifierProvider.notifier).loadMoreEpreuves();

// Rafraîchir
ref.read(epreuveNotifierProvider.notifier).refreshEpreuves();

// Créer une épreuve
ref.read(epreuveNotifierProvider.notifier).createEpreuve(data);
```

## ⚙️ Customisation

### Changer le nombre de groupes par requête

Dans `home_screen.dart`, modifiez les paramètres :
```dart
ref.read(epreuveNotifierProvider.notifier).loadEpreuves(
  groupBy: 'schoolName',    // ou 'matiere', 'niveau', etc.
  itemsPerGroup: 4,          // items par groupe
  groupsLimit: 18,           // nombre de groupes
);
```

### Changer le seuil de l'infinite scroll

Dans `_onScroll()` :
```dart
if (_scrollController.position.pixels >= 
    _scrollController.position.maxScrollExtent * 0.8) { // 80%
```

## 🐛 Debug

Les logs sont automatiquement affichés dans la console pour :
- Connexion Socket.IO
- Erreurs API
- Événements en temps réel reçus

---

**Architecture créée avec Riverpod + Freezed + Socket.IO**
