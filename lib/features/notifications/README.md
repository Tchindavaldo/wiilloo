# Page Notifications

## Description
La page notifications (`NotificationsScreen`) offre une gestion complète des notifications avec distinction entre messages lus et non lus.

## Fonctionnalités
- **Notifications variées** : Épreuves, corrections, messages, système
- **État lu/non lu** : Distinction visuelle claire avec badges
- **Filtrage avancé** : Par type et par état de lecture
- **Actions groupées** : Marquer tout comme lu, effacer tout
- **Navigation intelligente** : Redirection selon le type de notification
- **Paramètres personnalisables** : Types de notifications à recevoir

## Types de Notifications
- **Épreuves** : Nouvelles épreuves disponibles
- **Corrections** : Corrections IA terminées
- **Favoris** : Ajouts aux favoris
- **Messages** : Nouveaux messages de l'IA
- **Système** : Mises à jour et informations
- **Recommandations** : Contenu suggéré

## Interface
- **Header dynamique** : Compteur de notifications non lues
- **Filtres** : Chips pour filtrer par type/état
- **Cartes de notification** : Design différencié lu/non lu
- **Actions rapides** : Marquer comme lu individuellement
- **État vide** : Message adapté selon le filtre

## État Visuel
- **Non lu** : Fond bleu clair, bordure bleue, texte gras, indicateur bleu
- **Lu** : Fond blanc, bordure grise, texte normal
- **Badge** : Point bleu pour les notifications non lues

## Actions Disponibles
- **Tap sur notification** : Marquer comme lu + navigation
- **Marquer comme lu** : Bouton individuel
- **Tout lire** : Action groupée dans l'app bar
- **Tout effacer** : Floating action button avec confirmation
- **Paramètres** : Configuration des types de notifications

## Gestion des États
- **Compteur dynamique** : Mise à jour en temps réel
- **Filtrage instantané** : Sans recharger la page
- **Feedback haptique** : Pour toutes les interactions
- **SnackBar** : Confirmation des actions

## Timestamps
- Format relatif intelligent
- "À l'instant", "Il y a X min", "Il y a X h", "Il y a X j"
- Affichage simplifié sans heures
