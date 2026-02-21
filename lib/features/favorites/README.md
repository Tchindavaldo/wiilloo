# Page Favoris

## Description
La page favoris (`FavoritesScreen`) permet aux utilisateurs de gérer leurs épreuves favorites avec une interface moderne et intuitive.

## Fonctionnalités
- **Affichage des épreuves favorites** avec cartes détaillées
- **Filtrage par catégorie** (Math, Physique, Chimie, etc.)
- **Recherche et tri** des épreuves favorites
- **Navigation vers les détails** de chaque épreuve
- **Suppression des favoris** avec confirmation
- **Statistiques globales** (nombre d'épreuves, note moyenne, téléchargements)

## Interface
- Header avec titre et actions (recherche, filtre)
- Barre de catégories filtrables
- Barre de statistiques
- Liste des épreuves favorites avec cartes
- État vide si aucun favori

## État vide
L'écran affiche un message encourageant quand aucun favori n'est présent, avec un bouton pour explorer les épreuves.

## Interactions
- **Tap sur une carte** : Navigation vers les détails de l'épreuve
- **Tap sur cœur** : Suppression du favori avec SnackBar de confirmation
- **Filtres** : Filtrage dynamique par catégorie
- **Recherche** : Dialogue de recherche (à implémenter)
