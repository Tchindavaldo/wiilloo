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
}

class EpreuveSocketService {
  IO.Socket? _socket;
  final StreamController<SocketEventData> _eventController = StreamController.broadcast();
  
  Stream<SocketEventData> get eventStream => _eventController.stream;
  
  bool get isConnected => _socket?.connected ?? false;
  
  /// Initialize and connect to Socket.IO server
  void connect() {
    if (_socket != null && _socket!.connected) {
      return;
    }
    
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
      print('Socket.IO connected');
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
