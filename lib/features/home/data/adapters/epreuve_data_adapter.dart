import 'package:flutter/material.dart';
import '../models/epreuve_model.dart';
import '../models/epreuve_group_model.dart';

/// Adaptateur pour convertir les données du backend (EpreuveModel)
/// au format Map<String, dynamic> utilisé par les widgets existants
class EpreuveDataAdapter {
  
  /// Convertit un EpreuveModel en Map pour les widgets existants
  static Map<String, dynamic> epreuveToMap(EpreuveModel epreuve) {
    return {
      'id': epreuve.id,
      'title': epreuve.titre,
      'subject': epreuve.matiere,
      'level': epreuve.niveau,
      'duration': _formatDuration(epreuve.duree),
      'questions': 0, // Non disponible dans le backend
      'difficulty': _getDifficulty(epreuve.niveau),
      'downloads': epreuve.downloadCount,
      'rating': 4.5, // Valeur par défaut, à implémenter si disponible
      'year': epreuve.annee.toString(),
      'university': epreuve.schoolName,
      'class': epreuve.niveau,
      'period': epreuve.categorie,
      'hasCorrection': epreuve.hasCorrection,
      'color': const Color(0xFF3B82F6), // Couleur par défaut, sera remplacée dans epreuvesToMapList
      'icon': _getIconForSubject(epreuve.matiere),
      'category': epreuve.categorie,
      'description': epreuve.description,
      'bareme': epreuve.bareme,
      'fichiers': epreuve.fichiers.map((f) => {
        'nom': f.nom,
        'url': f.url,
        'type': f.type,
        'taille': f.taille,
        'uploadedAt': f.uploadedAt,
      }).toList(),
      'corrections': epreuve.corrections.map((c) => {
        'id': c.id,
        'titre': c.titre,
        'qualityLevel': c.qualityLevel,
        'correcteur': c.correcteur != null ? {
          'nom': c.correcteur!.nom,
          'prenom': c.correcteur!.prenom,
          'email': c.correcteur!.email,
          'telephone': c.correcteur!.telephone,
        } : null,
        'commentaire': c.commentaire,
        'fileUrl': c.fileUrl,
        'fileName': c.fileName,
        'fileType': c.fileType,
        'fileSize': c.fileSize,
        'driveFileId': c.driveFileId,
      }).toList(),
      'correctionsCount': epreuve.correctionsCount,
      'createdBy': epreuve.createdBy,
      'status': epreuve.status,
      'createdAt': epreuve.createdAt.seconds,
      'updatedAt': epreuve.updatedAt.seconds,
    };
  }
  
  /// Convertit une liste d'épreuves en Map pour les widgets
  static List<Map<String, dynamic>> epreuvesToMapList(List<EpreuveModel?> epreuves) {
    final validEpreuves = epreuves.where((e) => e != null).toList();
    return validEpreuves.asMap().entries.map((entry) {
      final index = entry.key;
      final epreuve = entry.value!;
      final data = epreuveToMap(epreuve);
      // Alterner les couleurs pour variété visuelle (comme design original)
      data['color'] = _getAlternatingColor(index);
      return data;
    }).toList();
  }
  
  /// Convertit un groupe d'épreuves pour les sections
  static Map<String, dynamic> groupToSection(EpreuveGroupModel group) {
    return {
      'id': group.id,
      'groupKey': group.groupKey,
      'groupBy': group.groupBy,
      'groupFields': group.groupFields,
      'epreuves': epreuvesToMapList(group.epreuves),
      'title': group.groupKey,
      'subtitle': '${group.epreuves.where((e) => e != null).length} épreuves disponibles',
      // Horizontal pagination metadata
      'hasMoreHorizontal': group.hasMoreHorizontal,
      'isLoadingHorizontal': group.isLoadingHorizontal,
      'totalInGroup': group.totalInGroup,
    };
  }
  
  /// Convertit tous les groupes en sections pour les widgets
  static List<Map<String, dynamic>> groupsToSections(List<EpreuveGroupModel> groups) {
    return groups.map((g) => groupToSection(g)).toList();
  }
  
  /// Formate la durée en format lisible
  static String _formatDuration(int dureeMinutes) {
    if (dureeMinutes == 0) return 'Non spécifié';
    if (dureeMinutes < 60) return '${dureeMinutes}min';
    
    final heures = dureeMinutes ~/ 60;
    final minutes = dureeMinutes % 60;
    
    if (minutes == 0) return '${heures}h';
    return '${heures}h${minutes}min';
  }
  
  /// Détermine la difficulté basée sur le niveau
  static String _getDifficulty(String niveau) {
    final niveauLower = niveau.toLowerCase();
    
    if (niveauLower.contains('cm') || niveauLower.contains('ce')) {
      return 'Facile';
    } else if (niveauLower.contains('6ème') || niveauLower.contains('5ème')) {
      return 'Facile';
    } else if (niveauLower.contains('4ème') || niveauLower.contains('3ème') || 
               niveauLower.contains('2nde')) {
      return 'Moyen';
    } else if (niveauLower.contains('1ère') || niveauLower.contains('terminale') ||
               niveauLower.contains('tle')) {
      return 'Moyen';
    } else {
      return 'Difficile';
    }
  }
  
  /// Retourne une couleur alternée - EXACTEMENT comme design original
  static Color _getAlternatingColor(int index) {
    // Couleurs EXACTES copiées du design original
    final colors = [
      const Color(0xFF3B82F6),  // 1. Bleu
      const Color(0xFF10B981),  // 2. Vert
      const Color(0xFF8B5CF6),  // 3. Violet
      const Color(0xFFEF4444),  // 4. Rouge
      const Color(0xFF06B6D4),  // 5. Cyan
      const Color(0xFFF59E0B),  // 6. Orange
      const Color(0xFFEC4899),  // 7. Rose
      const Color(0xFF6366F1),  // 8. Indigo
      const Color(0xFF14B8A6),  // 9. Teal
      const Color(0xFFF97316),  // 10. Orange foncé
    ];
    return colors[index % colors.length];
  }
  
  /// Retourne un emoji basé sur la matière
  static String _getIconForSubject(String matiere) {
    final matiereLower = matiere.toLowerCase();
    
    if (matiereLower.contains('math')) {
      return '📐';
    } else if (matiereLower.contains('physique') || matiereLower.contains('chimie')) {
      return '⚗️';
    } else if (matiereLower.contains('français') || matiereLower.contains('francais')) {
      return '📝';
    } else if (matiereLower.contains('anglais') || matiereLower.contains('english')) {
      return '🇬🇧';
    } else if (matiereLower.contains('histoire')) {
      return '📚';
    } else if (matiereLower.contains('geo')) {
      return '🌍';
    } else if (matiereLower.contains('svt') || matiereLower.contains('biologie')) {
      return '🧬';
    } else if (matiereLower.contains('info') || matiereLower.contains('computer')) {
      return '💻';
    } else if (matiereLower.contains('art')) {
      return '🎨';
    } else if (matiereLower.contains('musique')) {
      return '🎵';
    } else if (matiereLower.contains('sport') || matiereLower.contains('eps')) {
      return '⚽';
    } else {
      return '📖';
    }
  }
}
