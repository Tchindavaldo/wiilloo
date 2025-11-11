import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/auth_provider.dart';
import '../widgets/create_proof_steps/step1_basic_info.dart';
import '../widgets/create_proof_steps/step2_attach_files.dart';
import '../widgets/create_proof_steps/step3_review_confirm.dart';
import '../widgets/create_proof_steps/step4_payment.dart';
import '../widgets/create_proof_steps/custom_stepper.dart';
import '../widgets/payment/payment_form_modal.dart';
import '../widgets/payment/payment_loading_dialog.dart';
import 'payment_pending_screen.dart';
import 'request_success_screen.dart';
import '../../data/services/correction_request_service.dart';
import '../../data/services/file_upload_service.dart';
import '../../../home/data/services/epreuve_socket_service.dart';
import '../../../home/presentation/providers/epreuve_providers.dart';

class CreateProofRequestScreen extends ConsumerStatefulWidget {
  const CreateProofRequestScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateProofRequestScreen> createState() => _CreateProofRequestScreenState();
}

class _CreateProofRequestScreenState extends ConsumerState<CreateProofRequestScreen> {
  int _currentStep = 0;
  
  // Form data
  final Map<String, dynamic> _formData = {
    'title': '',
    'description': '',
    'dueDate': '',
    'priority': 'Medium',
    'quality': 'minimal', // minimal, standard, premium
    'files': [],
    'paymentMethod': 'credit-card',
  };

  // Service de demande de correction
  final CorrectionRequestService _requestService = CorrectionRequestService();
  StreamSubscription<SocketEventData>? _socketSubscription;
  
  // Données de paiement temporaires
  String? _phoneNumber;
  String? _cardNumber;
  String? _cardHolder;
  String? _expiryDate;
  String? _cvv;
  
  // Flags pour éviter les événements en double
  bool _paymentInitializedShown = false;
  bool _paymentValidatedShown = false;
  bool _creationLoaderShown = false;
  bool _successScreenShown = false;

  final List<String> _stepTitles = [
    'Basic Information',
    'Attach Files',
    'Review & Confirm',
    'Payment',
  ];

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Submit the form
      _submitRequest();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    
    // Vérifier l'utilisateur connecté
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      // Si pas d'utilisateur connecté, rediriger vers l'auth
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veuillez vous connecter')),
        );
      });
      return;
    }
    
    // Utiliser le service Socket.IO global
    final socketService = ref.read(epreuveSocketServiceProvider);
    
    // Connecter avec le userId si pas déjà connecté
    if (!socketService.isConnected) {
      socketService.connect(userId: currentUser.id);
    }
    
    // Écouter tous les événements Socket.IO
    _socketSubscription = socketService.eventStream.listen(
      (eventData) {
        print('🔔 Socket Event reçu: ${eventData.event}');
        print('🔔 Mounted: $mounted, Context: ${context.mounted}');
        if (!mounted) {
          print('⚠️  Widget not mounted, skipping event');
          return;
        }
        _handleSocketEvent(eventData);
      },
      onError: (error) {
        print('❌ Erreur dans le stream Socket.IO: $error');
      },
      onDone: () {
        print('⚠️  Stream Socket.IO fermé');
      },
      cancelOnError: false,
    );
    print('✅ Listener Socket.IO activé');
  }

  @override
  void dispose() {
    print('🔴 === DISPOSE CreateProofRequestScreen ===');
    print('🔴 Annulation du listener Socket.IO...');
    _socketSubscription?.cancel();
    super.dispose();
  }

  void _submitRequest() async {
    // Show payment form modal based on selected payment method
    final paymentMethod = _formData['paymentMethod'];
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PaymentFormModal(
        paymentMethod: paymentMethod,
        onSubmit: (paymentData) {
          // Sauvegarder les données de paiement
          setState(() {
            _phoneNumber = paymentData['phoneNumber'];
            _cardNumber = paymentData['cardNumber'];
            _cardHolder = paymentData['cardHolder'];
            _expiryDate = paymentData['expiryDate'];
            _cvv = paymentData['cvv'];
          });
          
          Navigator.pop(context); // Close payment form modal
          _processPayment(paymentMethod);
        },
      ),
    );
  }

  void _processPayment(String paymentMethod) async {
    // Réinitialiser les flags pour un nouveau paiement
    _paymentInitializedShown = false;
    _paymentValidatedShown = false;
    _creationLoaderShown = false;
    _successScreenShown = false;
    
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PaymentLoadingDialog(paymentMethod: paymentMethod),
    );

    // Calculer le montant basé sur la qualité
    double amount = 0;
    switch (_formData['quality']) {
      case 'minimal':
        amount = 0;
        break;
      case 'standard':
        amount = 2500;
        break;
      case 'premium':
        amount = 5000;
        break;
    }

    // Envoyer la demande au backend
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez vous connecter')),
      );
      return;
    }

    // Envoyer la demande de paiement avec les fichiers
    final result = await _requestService.createCorrectionRequestWithPayment(
      title: _formData['title'] ?? '',
      description: _formData['description'] ?? '',
      dueDate: _formData['dueDate'] ?? '',
      priority: _formData['priority'] ?? 'Medium',
      quality: _formData['quality'] ?? 'minimal',
      files: _formData['files'] ?? [], // ← Envoyer les fichiers en base64
      userId: currentUser.id,
      paymentMethod: paymentMethod,
      phoneNumber: _phoneNumber,
      cardNumber: _cardNumber,
      cardHolder: _cardHolder,
      expiryDate: _expiryDate,
      cvv: _cvv,
      amount: amount,
    );

    if (!mounted) return;
    
    if (!result['success']) {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Le traitement continue via Socket.IO
    // Les événements seront gérés par _handlePaymentEvent et _handleRequestEvent
  }

  void _handleSocketEvent(SocketEventData eventData) async {
    if (!mounted) return;

    switch (eventData.event) {
      // === ÉVÉNEMENTS DE PAIEMENT ===
      case SocketEvent.paymentInitialized:
        print('💳 === PAIEMENT INITIALISÉ ===');
        
        // Éviter les doublons
        if (_paymentInitializedShown) {
          print('⚠️  Dialog paiement pending déjà affiché, ignoré');
          return;
        }
        _paymentInitializedShown = true;
        
        // Paiement initialisé (Mobile Money/Orange Money)
        Navigator.pop(context); // Close loading dialog
        
        // Afficher un message invitant l'utilisateur à valider
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.phone_android,
                      size: 60,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'En attente de confirmation',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Veuillez composer le code USSD affiché sur votre téléphone pour confirmer le paiement',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        print('📱 Dialog pending affiché - En attente de validation utilisateur...');
        break;
        
      case SocketEvent.paymentValidated:
        print('💰 === PAIEMENT VALIDÉ ===');
        
        // Éviter les doublons
        if (_paymentValidatedShown) {
          print('⚠️  Message de paiement déjà affiché, ignoré');
          return;
        }
        _paymentValidatedShown = true;
        
        print('⏱️  Affichage du message de paiement validé...');
        
        // Fermer le loader de paiement
        Navigator.pop(context);
        
        // Afficher message de succès stylisé
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green.shade600,
                        size: 64,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Paiement validé !',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Votre paiement a été confirmé avec succès',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        
        print('⏱️  Message de paiement validé affiché');
        print('⏳ Attente de l\'événement request_creation_started du backend...');
        // Le délai d'affichage est géré côté backend
        // On attend juste l'événement request_creation_started
        break;
        
      case SocketEvent.requestCreationStarted:
        print('🚀 === CRÉATION LANCÉE ===');
        
        // Éviter les doublons
        if (_creationLoaderShown) {
          print('⚠️  Loader de création déjà affiché, ignoré');
          return;
        }
        _creationLoaderShown = true;
        
        print('⏱️  Fermeture du message de paiement validé...');
        
        // Fermer le message de paiement validé si encore ouvert
        if (mounted && Navigator.canPop(context)) {
          Navigator.pop(context);
          print('✅ Message de paiement fermé');
        }
        
        print('⏱️  Affichage du loader de création...');
        // Afficher loader de création de demande
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Création de la demande en cours...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Upload des fichiers vers Google Drive',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        print('✅ Loader de création affiché');
        print('⏳ Attente de l\'événement request_created du backend...');
        break;
        
      case SocketEvent.paymentFailed:
        print('❌ === PAIEMENT ÉCHOUÉ ===');
        Navigator.pop(context); // Close loading dialog
        final message = eventData.data['message'] ?? 'Erreur de paiement';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
        break;
        
      // === ÉVÉNEMENTS DE DEMANDE ===
        
      case SocketEvent.requestCreated:
        print('✅ === DEMANDE CRÉÉE AVEC SUCCÈS ===');
        
        // Éviter les doublons
        if (_successScreenShown) {
          print('⚠️  Page de succès déjà affichée, ignoré');
          return;
        }
        _successScreenShown = true;
        
        print('⏱️  Fermeture du loader de création...');
        
        // Demande créée avec succès
        Navigator.pop(context); // Close creation dialog
        
        print('🎉 Affichage de la page de succès...');
        _showSuccessScreen();
        break;
        
      case SocketEvent.requestCreationFailed:
        print('❌ === ÉCHEC DE LA CRÉATION ===');
        Navigator.pop(context); // Close creation dialog
        final message = eventData.data['message'] ?? 'Erreur lors de la création';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
        break;
        
      default:
        // Ignorer les autres événements (épreuves, corrections, etc.)
        break;
    }
  }

  Future<void> _uploadFilesAndCreateRequest() async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    try {
      // Upload des fichiers vers Google Drive
      print('📤 Upload des fichiers vers Google Drive...');
      final localFiles = _formData['files'] as List? ?? [];
      List<Map<String, dynamic>> uploadedFiles = [];
      
      final uploadService = FileUploadService();
      for (var localFile in localFiles) {
        if (localFile is Map && localFile['path'] != null) {
          try {
            final file = File(localFile['path']);
            final uploaded = await uploadService.uploadFile(file, userId: currentUser.id);
            if (uploaded != null) {
              uploadedFiles.add(uploaded);
            }
          } catch (e) {
            print('❌ Erreur upload fichier: $e');
          }
        }
      }

      if (uploadedFiles.isEmpty && localFiles.isNotEmpty) {
        Navigator.pop(context); // Close creation dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de l\'upload des fichiers'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      print('✅ Fichiers uploadés avec succès');
      // La demande sera créée via Socket.IO par le backend
      // On attend juste l'événement request_created
      
    } catch (e) {
      Navigator.pop(context); // Close creation dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  void _showPendingScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPendingScreen(
          onSuccess: () {
            Navigator.pop(context); // Close pending screen
            _showSuccessScreen();
          },
        ),
      ),
    );
  }

  void _showSuccessScreen() {
    // Replace the create proof request screen with success screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RequestSuccessScreen(),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return Step1BasicInfo(
          formData: _formData,
          onDataChanged: (key, value) {
            setState(() {
              _formData[key] = value;
            });
          },
        );
      case 1:
        return Step2AttachFiles(
          formData: _formData,
          onDataChanged: (key, value) {
            setState(() {
              _formData[key] = value;
            });
          },
        );
      case 2:
        return Step3ReviewConfirm(
          formData: _formData,
        );
      case 3:
        return Step4Payment(
          formData: _formData,
          onDataChanged: (key, value) {
            setState(() {
              _formData[key] = value;
            });
          },
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F7F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          _stepTitles[_currentStep],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Color(0xFF333333)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Custom Stepper
          CustomStepper(
            currentStep: _currentStep,
            totalSteps: 4,
            stepLabels: const [
              'Details',
              'Files',
              'Review',
              'Payment',
            ],
          ),
          
          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildStepContent(),
            ),
          ),
          
          // Bottom Navigation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F7F8),
              border: Border(
                top: BorderSide(color: const Color(0xFFDBE0E6)),
              ),
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Color(0xFFDBE0E6)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 16),
                Expanded(
                  flex: _currentStep == 0 ? 1 : 1,
                  child: ElevatedButton(
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1173D4),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _currentStep == 3 ? 'Submit Request' : 'Continue',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
