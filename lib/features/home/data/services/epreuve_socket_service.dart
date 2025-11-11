import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../core/config/environment_config.dart';
import '../models/epreuve_model.dart';

enum SocketEvent {
  epreuveCreated,
  epreuveUpdated,
  epreuveDeleted,
  correctionAdded,
  correctionUpdated,
  paymentInitialized,
  paymentValidated,
  paymentCompleted,
  paymentFailed,
  requestCreationStarted,
  requestCreated,
  requestCreationFailed,
}

class EpreuveSocketService {
  IO.Socket? _socket;
  final StreamController<SocketEventData> _eventController = StreamController<SocketEventData>.broadcast();
  String? _currentUserId;
  
  // Buffer pour stocker les événements temporairement
  final List<SocketEventData> _eventBuffer = [];
  bool _isProcessingBuffer = false;
  
  Stream<SocketEventData> get eventStream => _eventController.stream;
  
  bool get isConnected => _socket?.connected ?? false;
  
  /// Ajouter un événement au stream avec un délai pour garantir la livraison
  void _addEventWithDelay(SocketEventData event, {int delayMs = 100}) {
    Future.delayed(Duration(milliseconds: delayMs), () {
      if (!_eventController.isClosed) {
        _eventController.add(event);
        print('✅ Événement ${event.event} livré au stream après ${delayMs}ms');
      }
    });
  }
  
  /// Initialize and connect to Socket.IO server
  void connect({String? userId}) {
    if (_socket != null && _socket!.connected) {
      return;
    }
    
    _currentUserId = userId;
    
    _socket = IO.io(
      EnvironmentConfig.socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableReconnection()
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(5000)
          .setReconnectionAttempts(5)
          .build(),
    );
    
    _setupListeners();
  }
  
  void _setupListeners() {
    _socket?.onConnect((_) {
      print('🟢 Socket.IO connecté');
      
      // Rejoindre la room de l'utilisateur si userId fourni
      if (_currentUserId != null) {
        print('📡 Émission join_user avec userId: $_currentUserId');
        _socket?.emit('join_user', _currentUserId);
      }
    });
    
    _socket?.onDisconnect((_) {
      print('Socket.IO disconnected');
    });
    
    _socket?.onConnectError((error) {
      print('Socket.IO connection error: $error');
    });
    
    _socket?.onError((error) {
      print('Socket.IO error: $error');
    });
    
    // Listen for epreuve events
    _socket?.on('epreuve:created', (data) {
      try {
        final epreuve = EpreuveModel.fromJson(data);
        _eventController.add(SocketEventData(
          event: SocketEvent.epreuveCreated,
          data: epreuve,
        ));
      } catch (e) {
        print('Error parsing epreuve:created event: $e');
      }
    });
    
    _socket?.on('epreuve:updated', (data) {
      try {
        final epreuve = EpreuveModel.fromJson(data);
        _eventController.add(SocketEventData(
          event: SocketEvent.epreuveUpdated,
          data: epreuve,
        ));
      } catch (e) {
        print('Error parsing epreuve:updated event: $e');
      }
    });
    
    _socket?.on('epreuve:deleted', (data) {
      try {
        final epreuveId = data['id'] as String;
        _eventController.add(SocketEventData(
          event: SocketEvent.epreuveDeleted,
          data: epreuveId,
        ));
      } catch (e) {
        print('Error parsing epreuve:deleted event: $e');
      }
    });
    
    _socket?.on('correction:added', (data) {
      try {
        _eventController.add(SocketEventData(
          event: SocketEvent.correctionAdded,
          data: data,
        ));
      } catch (e) {
        print('Error parsing correction:added event: $e');
      }
    });
    
    _socket?.on('correction:updated', (data) {
      try {
        _eventController.add(SocketEventData(
          event: SocketEvent.correctionUpdated,
          data: data,
        ));
      } catch (e) {
        print('Error parsing correction:updated event: $e');
      }
    });
    
    // === ÉVÉNEMENTS DE PAIEMENT ===
    _socket?.on('payment_initialized', (data) {
      print('💳 Socket.IO: payment_initialized reçu');
      _eventController.add(SocketEventData(
        event: SocketEvent.paymentInitialized,
        data: data,
      ));
    });
    
    _socket?.on('payment_validated', (data) {
      print('✅ Socket.IO: payment_validated reçu');
      _eventController.add(SocketEventData(
        event: SocketEvent.paymentValidated,
        data: data,
      ));
    });
    
    _socket?.on('payment_completed', (data) {
      print('✅ Socket.IO: payment_completed reçu');
      _eventController.add(SocketEventData(
        event: SocketEvent.paymentCompleted,
        data: data,
      ));
    });
    
    _socket?.on('payment_failed', (data) {
      print('❌ Socket.IO: payment_failed reçu');
      _eventController.add(SocketEventData(
        event: SocketEvent.paymentFailed,
        data: data,
      ));
    });
    
    // === ÉVÉNEMENTS DE DEMANDE ===
    _socket?.on('request_creation_started', (data) {
      print('📝 Socket.IO: request_creation_started reçu');
      print('📝 Ajout de l\'événement requestCreationStarted avec délai...');
      _addEventWithDelay(
        SocketEventData(
          event: SocketEvent.requestCreationStarted,
          data: data,
        ),
        delayMs: 200, // Délai pour laisser le dialog de paiement s'afficher
      );
    });
    
    _socket?.on('request_created', (data) {
      print('✅ Socket.IO: request_created reçu');
      print('✅ Ajout de l\'événement requestCreated avec délai...');
      _addEventWithDelay(
        SocketEventData(
          event: SocketEvent.requestCreated,
          data: data,
        ),
        delayMs: 200, // Délai pour laisser le loader s'afficher
      );
    });
    
    _socket?.on('request_creation_failed', (data) {
      print('❌ Socket.IO: request_creation_failed reçu');
      _eventController.add(SocketEventData(
        event: SocketEvent.requestCreationFailed,
        data: data,
      ));
    });
  }
  
  /// Join a specific room (e.g., for school-specific updates)
  void joinRoom(String roomName) {
    _socket?.emit('join', roomName);
  }
  
  /// Leave a specific room
  void leaveRoom(String roomName) {
    _socket?.emit('leave', roomName);
  }
  
  /// Disconnect from Socket.IO server
  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }
  
  /// Dispose of resources
  void dispose() {
    disconnect();
    _eventController.close();
  }
}

class SocketEventData {
  final SocketEvent event;
  final dynamic data;
  
  SocketEventData({
    required this.event,
    required this.data,
  });
}
