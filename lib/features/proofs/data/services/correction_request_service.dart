import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../core/config/environment_config.dart';

/// Service pour gérer les demandes de correction avec paiement
/// Utilise Socket.IO pour les notifications en temps réel
class CorrectionRequestService {
  IO.Socket? _socket;
  final StreamController<PaymentEvent> _paymentEventController = StreamController.broadcast();
  final StreamController<RequestEvent> _requestEventController = StreamController.broadcast();
  
  Stream<PaymentEvent> get paymentEventStream => _paymentEventController.stream;
  Stream<RequestEvent> get requestEventStream => _requestEventController.stream;
  
  String get _baseUrl => EnvironmentConfig.apiBaseUrl;
  String get _socketUrl => EnvironmentConfig.socketUrl;
  
  bool get isConnected => _socket?.connected ?? false;

  /// Initialiser la connexion Socket.IO
  void connect(String userId) {
    if (_socket != null && _socket!.connected) {
      return;
    }
    
    _socket = IO.io(
      _socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket', 'polling'])
          .enableAutoConnect()
          .enableReconnection()
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(5000)
          .setReconnectionAttempts(999)
          .build(),
    );
    
    _setupListeners(userId);
  }

  void _setupListeners(String userId) {
    _socket?.onConnect((_) {
      print('🟢 Socket.IO connecté');
      // Rejoindre la room de l'utilisateur
      print('📡 Émission join_user avec userId: $userId');
      _socket?.emit('join_user', userId);
    });
    
    _socket?.onDisconnect((_) {
      print('🔴 Socket.IO déconnecté');
    });
    
    _socket?.onConnectError((error) {
      print('❌ Erreur connexion Socket.IO: $error');
    });

    // === ÉVÉNEMENTS DE PAIEMENT ===
    
    // Paiement initialisé (Mobile Money / Orange Money)
    _socket?.on('payment_initialized', (data) {
      print('💳 Socket.IO: payment_initialized reçu');
      _paymentEventController.add(PaymentEvent(
        type: PaymentEventType.initialized,
        transactionId: data['transactionId'],
        status: data['status'],
        message: data['message'],
        ussdCode: data['ussdCode'],
      ));
    });
    
    // Paiement validé (Mobile Money / Orange Money)
    _socket?.on('payment_validated', (data) {
      print('✅ Socket.IO: payment_validated reçu');
      _paymentEventController.add(PaymentEvent(
        type: PaymentEventType.validated,
        transactionId: data['transactionId'],
        status: data['status'],
        message: data['message'],
      ));
    });
    
    // Paiement complété (Carte bancaire)
    _socket?.on('payment_completed', (data) {
      print('✅ Socket.IO: payment_completed reçu');
      _paymentEventController.add(PaymentEvent(
        type: PaymentEventType.completed,
        transactionId: data['transactionId'],
        status: data['status'],
        message: data['message'],
      ));
    });
    
    // Paiement échoué
    _socket?.on('payment_failed', (data) {
      print('❌ Socket.IO: payment_failed reçu');
      _paymentEventController.add(PaymentEvent(
        type: PaymentEventType.failed,
        message: data['message'],
        status: data['status'],
      ));
    });

    // === ÉVÉNEMENTS DE DEMANDE ===
    
    // Création de la demande commencée
    _socket?.on('request_creation_started', (data) {
      print('📝 Socket.IO: request_creation_started reçu');
      _requestEventController.add(RequestEvent(
        type: RequestEventType.creationStarted,
        message: data['message'],
        status: data['status'],
      ));
    });
    
    // Demande créée avec succès
    _socket?.on('request_created', (data) {
      print('✅ Socket.IO: request_created reçu');
      _requestEventController.add(RequestEvent(
        type: RequestEventType.created,
        message: data['message'],
        status: data['status'],
        requestId: data['requestId'],
        data: data['data'],
      ));
    });
    
    // Échec de création de la demande
    _socket?.on('request_creation_failed', (data) {
      print('❌ Socket.IO: request_creation_failed reçu');
      _requestEventController.add(RequestEvent(
        type: RequestEventType.failed,
        message: data['message'],
        status: data['status'],
      ));
    });
  }

  /// Créer une demande de correction avec paiement
  /// Endpoint combiné qui gère paiement + création
  Future<Map<String, dynamic>> createCorrectionRequestWithPayment({
    required String title,
    required String description,
    required String dueDate,
    required String priority,
    required String quality,
    required List<Map<String, dynamic>> files,
    required String userId,
    required String paymentMethod,
    String? phoneNumber,
    String? cardNumber,
    String? cardHolder,
    String? expiryDate,
    String? cvv,
    required double amount,
  }) async {
    try {
      print('🚀 Envoi demande de correction avec paiement...');
      
      final response = await http.post(
        Uri.parse('$_baseUrl/api/corrections/payment-and-request'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          // Données de la demande
          'title': title,
          'description': description,
          'dueDate': dueDate,
          'priority': priority,
          'quality': quality,
          'files': files,
          'userId': userId,
          
          // Données de paiement
          'paymentMethod': paymentMethod,
          'phoneNumber': phoneNumber,
          'cardNumber': cardNumber,
          'cardHolder': cardHolder,
          'expiryDate': expiryDate,
          'cvv': cvv,
          'amount': amount,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 202 || response.statusCode == 200) {
        print('✅ Demande acceptée, traitement en cours...');
        return {
          'success': true,
          'message': data['message'],
          'status': data['status'],
        };
      } else {
        print('❌ Erreur: ${data['message']}');
        return {
          'success': false,
          'message': data['message'] ?? 'Erreur lors de la création',
        };
      }
    } catch (e) {
      print('❌ Exception: $e');
      return {
        'success': false,
        'message': 'Erreur de connexion au serveur',
      };
    }
  }

  /// Déconnecter Socket.IO
  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }

  /// Nettoyer les ressources
  void dispose() {
    disconnect();
    _paymentEventController.close();
    _requestEventController.close();
  }
}

/// Types d'événements de paiement
enum PaymentEventType {
  initialized,
  validated,
  completed,
  failed,
}

/// Événement de paiement
class PaymentEvent {
  final PaymentEventType type;
  final String? transactionId;
  final String? status;
  final String message;
  final String? ussdCode;

  PaymentEvent({
    required this.type,
    this.transactionId,
    this.status,
    required this.message,
    this.ussdCode,
  });
}

/// Types d'événements de demande
enum RequestEventType {
  creationStarted,
  created,
  failed,
}

/// Événement de demande
class RequestEvent {
  final RequestEventType type;
  final String message;
  final String status;
  final String? requestId;
  final Map<String, dynamic>? data;

  RequestEvent({
    required this.type,
    required this.message,
    required this.status,
    this.requestId,
    this.data,
  });
}
