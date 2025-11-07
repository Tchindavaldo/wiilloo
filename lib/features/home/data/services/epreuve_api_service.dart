import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/environment_config.dart';
import '../models/epreuve_model.dart';
import '../models/epreuve_group_model.dart';

class EpreuveApiService {
  final http.Client _client;
  
  EpreuveApiService({http.Client? client}) : _client = client ?? http.Client();
  
  String get _baseUrl => EnvironmentConfig.apiBaseUrl;
  
  /// Fetch epreuves with pagination and grouping
  /// 
  /// Parameters:
  /// - [cursor]: Current pagination cursor (default: 0)
  /// - [groupBy]: Field to group by (default: 'schoolName')
  /// - [itemsPerGroup]: Number of items per group (default: 4)
  /// - [groupsLimit]: Maximum number of groups to fetch (default: 18)
  /// - [lastDocId]: Last document ID for pagination (required when cursor > 0)
  /// - [paginationState]: Pagination state (optional)
  Future<EpreuvesResponseModel> fetchEpreuves({
    int cursor = 0,
    String groupBy = 'schoolName',
    int itemsPerGroup = 4,
    int groupsLimit = 18,
    String? lastDocId,
    String? paginationState,
  }) async {
    try {
      final queryParams = {
        'cursor': cursor.toString(),
        'groupBy': groupBy,
        'itemsPerGroup': itemsPerGroup.toString(),
        'groupsLimit': groupsLimit.toString(),
      };
      
      // Ajouter lastDocId et paginationState si présents (requis pour cursor > 0)
      if (lastDocId != null && lastDocId.isNotEmpty) {
        queryParams['lastDocId'] = lastDocId;
      }
      if (paginationState != null && paginationState.isNotEmpty) {
        queryParams['paginationState'] = paginationState;
      }
      
      final uri = Uri.parse('$_baseUrl/api/epreuves').replace(
        queryParameters: queryParams,
      );
      
      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        
        // Parse horizontal pagination metadata from _meta in each group
        if (jsonData['items'] != null && jsonData['items'] is List) {
          for (var i = 0; i < jsonData['items'].length; i++) {
            final groupJson = jsonData['items'][i];
            if (groupJson['_meta'] != null) {
              final meta = groupJson['_meta'];
              final horizontalPagination = meta['horizontalPagination'];
              
              // Inject horizontal pagination fields into the group JSON
              groupJson['hasMoreHorizontal'] = horizontalPagination?['hasMore'] ?? false;
              groupJson['nextHorizontalCursor'] = horizontalPagination?['nextCursor'];
              groupJson['currentHorizontalOffset'] = meta['currentOffset'] ?? 0;
              groupJson['totalInGroup'] = meta['totalInGroup'];
              groupJson['isLoadingHorizontal'] = false;
            } else {
              // No metadata - set defaults
              final epreuvesCount = (groupJson['epreuves'] as List?)?.where((e) => e != null).length ?? 0;
              groupJson['hasMoreHorizontal'] = true; // Assume more exist
              groupJson['nextHorizontalCursor'] = null;
              groupJson['currentHorizontalOffset'] = epreuvesCount;
              groupJson['totalInGroup'] = null;
              groupJson['isLoadingHorizontal'] = false;
            }
          }
        }
        
        return EpreuvesResponseModel.fromJson(jsonData);
      } else {
        throw EpreuveApiException(
          'Failed to fetch epreuves: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is EpreuveApiException) rethrow;
      throw EpreuveApiException('Network error: $e');
    }
  }
  
  /// Fetch more epreuves horizontally for a specific group
  /// 
  /// This uses groupOffset for horizontal pagination within a single group.
  /// The backend should be filtered to return only one group's next items.
  /// 
  /// Parameters:
  /// - [groupBy]: Field to group by (e.g., 'schoolName')
  /// - [groupFilters]: Filters to apply (e.g., {'schoolName': 'ISSTAG'})
  /// - [groupOffset]: Offset within the group for horizontal pagination
  /// - [itemsPerGroup]: Number of items to fetch (default: 4)
  Future<EpreuvesResponseModel> fetchMoreHorizontal({
    required String groupBy,
    required Map<String, dynamic> groupFilters,
    required int groupOffset,
    int itemsPerGroup = 4,
  }) async {
    try {
      final queryParams = {
        'groupBy': groupBy,
        'itemsPerGroup': itemsPerGroup.toString(),
        'groupsLimit': '1', // Always 1 since we're fetching for a specific group
        'groupOffset': groupOffset.toString(),
      };
      
      // Add group filters (e.g., schoolName, matiere, etc.)
      groupFilters.forEach((key, value) {
        if (value != null) {
          queryParams[key] = value.toString();
        }
      });
      
      final uri = Uri.parse('$_baseUrl/api/epreuves').replace(
        queryParameters: queryParams,
      );
      
      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        
        // Parse horizontal pagination metadata from _meta in the group
        if (jsonData['items'] != null && jsonData['items'] is List && jsonData['items'].isNotEmpty) {
          final groupJson = jsonData['items'][0]; // Only one group for horizontal pagination
          if (groupJson['_meta'] != null) {
            final meta = groupJson['_meta'];
            final horizontalPagination = meta['horizontalPagination'];
            
            // Inject horizontal pagination fields into the group JSON
            groupJson['hasMoreHorizontal'] = horizontalPagination?['hasMore'] ?? false;
            groupJson['nextHorizontalCursor'] = horizontalPagination?['nextCursor'];
            groupJson['currentHorizontalOffset'] = meta['currentOffset'] ?? 0;
            groupJson['totalInGroup'] = meta['totalInGroup'];
            groupJson['isLoadingHorizontal'] = false;
          }
        }
        
        return EpreuvesResponseModel.fromJson(jsonData);
      } else {
        throw EpreuveApiException(
          'Failed to fetch more horizontal: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is EpreuveApiException) rethrow;
      throw EpreuveApiException('Network error: $e');
    }
  }
  
  /// Create a new epreuve
  Future<EpreuveModel> createEpreuve(Map<String, dynamic> data) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/api/epreuves'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return EpreuveModel.fromJson(jsonData['data']);
      } else {
        throw EpreuveApiException(
          'Failed to create epreuve: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is EpreuveApiException) rethrow;
      throw EpreuveApiException('Network error: $e');
    }
  }
  
  /// Update an existing epreuve
  Future<EpreuveModel> updateEpreuve(String id, Map<String, dynamic> data) async {
    try {
      final response = await _client.put(
        Uri.parse('$_baseUrl/api/epreuves/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return EpreuveModel.fromJson(jsonData['data']);
      } else {
        throw EpreuveApiException(
          'Failed to update epreuve: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is EpreuveApiException) rethrow;
      throw EpreuveApiException('Network error: $e');
    }
  }
  
  /// Delete an epreuve
  Future<void> deleteEpreuve(String id) async {
    try {
      final response = await _client.delete(
        Uri.parse('$_baseUrl/api/epreuves/$id'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw EpreuveApiException(
          'Failed to delete epreuve: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is EpreuveApiException) rethrow;
      throw EpreuveApiException('Network error: $e');
    }
  }
  
  /// Get a single epreuve by ID
  Future<EpreuveModel> getEpreuveById(String id) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/api/epreuves/$id'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return EpreuveModel.fromJson(jsonData['data']);
      } else {
        throw EpreuveApiException(
          'Failed to fetch epreuve: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is EpreuveApiException) rethrow;
      throw EpreuveApiException('Network error: $e');
    }
  }
  
  void dispose() {
    _client.close();
  }
}

class EpreuveApiException implements Exception {
  final String message;
  final int? statusCode;
  
  EpreuveApiException(this.message, {this.statusCode});
  
  @override
  String toString() => 'EpreuveApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}
