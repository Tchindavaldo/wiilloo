# Page Épreuve

## Description
La page d'épreuve (`EpreuveScreen`) permet d'afficher les détails complets d'une épreuve avec les fonctionnalités suivantes :

## Fonctionnalités
- **Visualisation complète** de l'épreuve avec aperçu
- **Bouton favoris** pour ajouter/retirer des épreuves favorites
- **Bouton téléchargement** pour télécharger l'épreuve
- **Correction IA** disponible si l'épreuve a un corrigé
- **Interface moderne** avec design material

## Navigation
La page est accessible depuis le `HomeScreen` en cliquant sur "Voir l'épreuve" dans la fonction `_showEpreuveDetails`.

## Structure
- Header avec informations principales (titre, matière, université, classe, année)
- Section statistiques (durée, questions, note, téléchargements)
- Contenu de l'épreuve avec aperçu
- Section correction (si disponible)
- Barre d'action inférieure avec boutons téléchargement et correction IA

## Paramètres
La page accepte un paramètre obligatoire :
- `epreuve`: Map<String, dynamic> contenant toutes les informations de l'épreuve

## États
- Gestion de l'état favoris
- Gestion de l'état de téléchargement
- Feedback utilisateur avec SnackBars
- Feedback haptique pour meilleure expérience
