import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import '../../../../core/config/environment_config.dart';

/// Service pour uploader des fichiers vers Google Drive via le backend
class FileUploadService {
  String get _baseUrl => EnvironmentConfig.apiBaseUrl;

  /// Uploader un fichier vers Google Drive
  /// Utilise l'endpoint /api/upload/temp du backend
  Future<Map<String, dynamic>?> uploadFile(File file, {required String userId}) async {
    try {
      print('📤 Upload fichier: ${file.path} pour user $userId');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/api/upload/temp'),
      );

      // Ajouter le userId
      request.fields['userId'] = userId;

      // Ajouter le fichier
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
        ),
      );

      // Envoyer la requête
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['success'] == true) {
          print('✅ Fichier uploadé: ${data['data']['url']}');
          return {
            'name': data['data']['originalName'],
            'url': data['data']['url'],
            'driveFileId': data['data']['driveFileId'],
            'size': data['data']['size'],
            'mimetype': data['data']['mimetype'],
          };
        }
      }

      print('❌ Erreur upload: ${response.body}');
      return null;
    } catch (e) {
      print('❌ Exception upload: $e');
      return null;
    }
  }

  /// Sélectionner et uploader plusieurs fichiers
  Future<List<Map<String, dynamic>>> pickAndUploadFiles({required String userId}) async {
    try {
      // Ouvrir le sélecteur de fichiers
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        allowMultiple: true,
      );

      if (result == null || result.files.isEmpty) {
        return [];
      }

      List<Map<String, dynamic>> uploadedFiles = [];

      // Uploader chaque fichier
      for (var platformFile in result.files) {
        if (platformFile.path != null) {
          final file = File(platformFile.path!);
          final uploadedFile = await uploadFile(file, userId: userId);
          
          if (uploadedFile != null) {
            uploadedFiles.add(uploadedFile);
          }
        }
      }

      return uploadedFiles;
    } catch (e) {
      print('❌ Erreur sélection fichiers: $e');
      return [];
    }
  }

  /// Uploader un seul fichier avec sélecteur
  Future<Map<String, dynamic>?> pickAndUploadSingleFile({required String userId}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        return null;
      }

      final platformFile = result.files.first;
      if (platformFile.path != null) {
        final file = File(platformFile.path!);
        return await uploadFile(file, userId: userId);
      }

      return null;
    } catch (e) {
      print('❌ Erreur sélection fichier: $e');
      return null;
    }
  }
}
