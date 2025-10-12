# Feature Home - Wiilloo

## 📱 Structure

Le dossier `home` contient toute la logique et l'UI de l'écran d'accueil principal de l'application Wiilloo.

### Architecture

```
home/
├── presentation/
│   ├── screens/
│   │   └── home_screen.dart          # Écran principal avec navigation
│   └── widgets/
│       ├── home_header.dart           # Header avec recherche, notifications, avatar
│       ├── category_chips.dart        # Chips de catégories scrollables
│       ├── auto_slide_cards.dart      # Carrousel auto-défilant
│       ├── epreuve_card_section.dart  # Section de cartes style 1 (verticales)
│       ├── featured_epreuve_card.dart # Cartes style 2 (featured avec bordure)
│       └── compact_epreuve_card.dart  # Cartes style 3 (compactes)
```

## 🎨 Design Features

### Header
- **Barre de recherche** : Design moderne avec ombre et icône de recherche
- **Icône de notification** : Avec badge rouge pour nouvelles notifications
- **Avatar profil** : Gradient bleu-violet avec ombre

### Sections de Cartes

#### 1. Auto-Slide Cards
- Défilement automatique toutes les 4 secondes
- Indicateurs de pagination animés
- Design gradient avec patterns décoratifs
- Affichage rating, durée, nombre de questions

#### 2. Épreuves Populaires (Style 1)
- Cartes verticales avec header coloré
- Badge "Corrigé" si disponible
- Stats : downloads et rating
- Scrolling horizontal

#### 3. Nouvelles Épreuves (Style 2)
- Cards featured avec bordure colorée
- Badge "NEW" avec gradient rose-rouge
- Design plus aéré et élégant
- Background gradient subtil

#### 4. Recommandations (Style 3)
- Cartes compactes
- Icon centré dans header coloré
- Format plus petit pour voir plus de contenu
- Check icon vert pour corrigés

### Navigation Bar
- 4 sections : Accueil, Favoris, Alertes, Profil
- Animation sur sélection
- Icons arrondis avec couleurs
- Design minimaliste et moderne

## 🎯 Fonctionnalités

- **Recherche d'épreuves** par titre ou matière
- **Filtrage par catégorie** avec chips animés
- **Visualisation des détails** via modal bottom sheet
- **Navigation fluide** entre les sections
- **Animations** sur interactions utilisateur

## 🎨 Palette de Couleurs

- **Primaire** : #3B82F6 (Bleu)
- **Secondaire** : #8B5CF6 (Violet)
- **Succès** : #10B981 (Vert)
- **Danger** : #EF4444 (Rouge)
- **Warning** : #F59E0B (Orange)
- **Background** : #F8FAFC (Gris très clair)

## 📊 Type de Données

Chaque épreuve contient :
- `id` : Identifiant unique
- `title` : Titre de l'épreuve
- `subject` : Matière
- `level` : Niveau scolaire
- `duration` : Durée
- `questions` : Nombre de questions
- `difficulty` : Niveau de difficulté
- `downloads` : Nombre de téléchargements
- `rating` : Note moyenne
- `year` : Année
- `hasCorrection` : Correction disponible (bool)
- `color` : Couleur thématique
- `icon` : Emoji représentatif
