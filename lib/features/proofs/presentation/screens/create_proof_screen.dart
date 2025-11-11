import 'package:flutter/material.dart';
import '../widgets/create_proof_steps/proof_step1_basic_info.dart';
import '../widgets/create_proof_steps/proof_step2_correction_details.dart';
import '../widgets/create_proof_steps/proof_step3_upload_images.dart';

class CreateProofScreen extends StatefulWidget {
  const CreateProofScreen({Key? key}) : super(key: key);

  @override
  State<CreateProofScreen> createState() => _CreateProofScreenState();
}

class _CreateProofScreenState extends State<CreateProofScreen> {
  int _currentStep = 0;
  final Map<String, dynamic> _formData = {};

  void _onDataChanged(String key, dynamic value) {
    setState(() {
      _formData[key] = value;
    });
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Submit proof
      _submitProof();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _submitProof() {
    // TODO: Implement proof submission
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Proof submitted successfully!'),
        backgroundColor: Color(0xFF10B981),
      ),
    );
    Navigator.pop(context);
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Create Proof (1/3)';
      case 1:
        return 'Create Proof (2/3)';
      case 2:
        return 'Create Proof (3/3)';
      default:
        return 'Create Proof';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B), size: 20),
            onPressed: _previousStep,
            padding: EdgeInsets.zero,
          ),
        ),
        title: Text(
          _getStepTitle(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
              ),
            ),
            child: Row(
              children: [
                _buildProgressStep(0, 'Basic Info'),
                Expanded(
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _currentStep >= 1
                            ? [const Color(0xFF4A90E2), const Color(0xFF4A90E2)]
                            : [const Color(0xFFE2E8F0), const Color(0xFFE2E8F0)],
                      ),
                    ),
                  ),
                ),
                _buildProgressStep(1, 'Corrections'),
                Expanded(
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _currentStep >= 2
                            ? [const Color(0xFF4A90E2), const Color(0xFF4A90E2)]
                            : [const Color(0xFFE2E8F0), const Color(0xFFE2E8F0)],
                      ),
                    ),
                  ),
                ),
                _buildProgressStep(2, 'Images'),
              ],
            ),
          ),
          
          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildCurrentStep(),
            ),
          ),
          
          // Bottom Navigation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 20,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Color(0xFF4A90E2), width: 2),
                        foregroundColor: const Color(0xFF4A90E2),
                      ),
                      child: Text(
                        _currentStep == 0 ? 'Cancel' : 'Previous',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4A90E2).withOpacity(0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Text(
                          _currentStep == 2 ? 'Submit Proof' : 'Next',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep(int step, String label) {
    final isActive = _currentStep == step;
    final isCompleted = _currentStep > step;
    
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            gradient: isCompleted || isActive
                ? const LinearGradient(
                    colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                  )
                : null,
            color: isCompleted || isActive ? null : const Color(0xFFE2E8F0),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : Text(
                    '${step + 1}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isActive ? Colors.white : const Color(0xFF94A3B8),
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isActive || isCompleted
                ? const Color(0xFF4A90E2)
                : const Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return ProofStep1BasicInfo(
          formData: _formData,
          onDataChanged: _onDataChanged,
        );
      case 1:
        return ProofStep2CorrectionDetails(
          formData: _formData,
          onDataChanged: _onDataChanged,
        );
      case 2:
        return ProofStep3UploadImages(
          formData: _formData,
          onDataChanged: _onDataChanged,
        );
      default:
        return const SizedBox();
    }
  }
}
