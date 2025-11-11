import 'dart:async';
import '../models/epreuve_group_model.dart';
import '../models/epreuve_model.dart';
import '../services/epreuve_api_service.dart';
import '../services/epreuve_socket_service.dart';

class EpreuveRepository {
  final EpreuveApiService _apiService;
  final EpreuveSocketService _socketService;
  
  EpreuveRepository({
    required EpreuveApiService apiService,
    required EpreuveSocketService socketService,
  })  : _apiService = apiService,
        _socketService = socketService {
    _initializeSocketListeners();
  }
  
  // Stream controller for real-time updates
  final StreamController<RepositoryEvent> _eventController = StreamController.broadcast();
  Stream<RepositoryEvent> get eventStream => _eventController.stream;
  
  void _initializeSocketListeners() {
    _socketService.eventStream.listen((socketEvent) {
      switch (socketEvent.event) {
        case SocketEvent.epreuveCreated:
          _eventController.add(RepositoryEvent(
            type: RepositoryEventType.created,
            data: socketEvent.data,
          ));
          break;
        case SocketEvent.epreuveUpdated:
          _eventController.add(RepositoryEvent(
            type: RepositoryEventType.updated,
            data: socketEvent.data,
          ));
          break;
        case SocketEvent.epreuveDeleted:
          _eventController.add(RepositoryEvent(
            type: RepositoryEventType.deleted,
            data: socketEvent.data,
          ));
          break;
        case SocketEvent.correctionAdded:
        case SocketEvent.correctionUpdated:
          _eventController.add(RepositoryEvent(
            type: RepositoryEventType.correctionUpdated,
            data: socketEvent.data,
          ));
          break;
        
        // Ignorer les événements de paiement et de demande (gérés ailleurs)
        case SocketEvent.paymentInitialized:
        case SocketEvent.paymentValidated:
        case SocketEvent.paymentCompleted:
        case SocketEvent.paymentFailed:
        case SocketEvent.requestCreationStarted:
        case SocketEvent.requestCreated:
        case SocketEvent.requestCreationFailed:
          // Ces événements sont gérés dans create_proof_request_screen
          break;
      }
    });
  }
  
  /// Fetch epreuves with pagination
  Future<EpreuvesResponseModel> fetchEpreuves({
    int cursor = 0,
    String groupBy = 'schoolName',
    int itemsPerGroup = 4,
    int groupsLimit = 18,
    String? lastDocId,
    String? paginationState,
  }) async {
    return await _apiService.fetchEpreuves(
      cursor: cursor,
      groupBy: groupBy,
      itemsPerGroup: itemsPerGroup,
      groupsLimit: groupsLimit,
      lastDocId: lastDocId,
      paginationState: paginationState,
    );
  }
  
  /// Fetch more epreuves horizontally for a specific group
  Future<EpreuvesResponseModel> fetchMoreHorizontal({
    required String groupBy,
    required Map<String, dynamic> groupFilters,
    required int groupOffset,
    int itemsPerGroup = 4,
  }) async {
    return await _apiService.fetchMoreHorizontal(
      groupBy: groupBy,
      groupFilters: groupFilters,
      groupOffset: groupOffset,
      itemsPerGroup: itemsPerGroup,
    );
  }
  
  /// Create a new epreuve
  Future<EpreuveModel> createEpreuve(Map<String, dynamic> data) async {
    return await _apiService.createEpreuve(data);
  }
  
  /// Update an existing epreuve
  Future<EpreuveModel> updateEpreuve(String id, Map<String, dynamic> data) async {
    return await _apiService.updateEpreuve(id, data);
  }
  
  /// Delete an epreuve
  Future<void> deleteEpreuve(String id) async {
    await _apiService.deleteEpreuve(id);
  }
  
  /// Get a single epreuve by ID
  Future<EpreuveModel> getEpreuveById(String id) async {
    return await _apiService.getEpreuveById(id);
  }
  
  /// Connect to Socket.IO for real-time updates
  void connectSocket() {
    _socketService.connect();
  }
  
  /// Disconnect from Socket.IO
  void disconnectSocket() {
    _socketService.disconnect();
  }
  
  /// Join a specific room for targeted updates
  void joinRoom(String roomName) {
    _socketService.joinRoom(roomName);
  }
  
  /// Leave a specific room
  void leaveRoom(String roomName) {
    _socketService.leaveRoom(roomName);
  }
  
  void dispose() {
    _eventController.close();
    _socketService.dispose();
    _apiService.dispose();
  }
}

enum RepositoryEventType {
  created,
  updated,
  deleted,
  correctionUpdated,
}

class RepositoryEvent {
  final RepositoryEventType type;
  final dynamic data;
  
  RepositoryEvent({
    required this.type,
    required this.data,
  });
}
