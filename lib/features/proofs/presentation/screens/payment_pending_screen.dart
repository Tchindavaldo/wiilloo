import 'package:flutter/material.dart';
import 'dart:async';

class PaymentPendingScreen extends StatefulWidget {
  final VoidCallback onSuccess;

  const PaymentPendingScreen({
    Key? key,
    required this.onSuccess,
  }) : super(key: key);

  @override
  State<PaymentPendingScreen> createState() => _PaymentPendingScreenState();
}

class _PaymentPendingScreenState extends State<PaymentPendingScreen> {
  int _remainingSeconds = 120; // 2 minutes
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    // Simulate payment confirmation after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        widget.onSuccess();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Main content - centered
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated hourglass spinner
                    SizedBox(
                      width: 96,
                      height: 96,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Rotating dashed border
                          SizedBox(
                            width: 96,
                            height: 96,
                            child: CircularProgressIndicator(
                              strokeWidth: 4,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF1173D4),
                              ),
                            ),
                          ),
                          // Center icon with background
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1173D4).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.hourglass_top,
                              size: 48,
                              color: Color(0xFF1173D4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Title
                    const Text(
                      'Pending Confirmation',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    
                    // Description
                    const Text(
                      'Dial this code on your phone to approve the transaction.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF617589),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 24),
                    
                    // USSD Code
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F2F4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '*150#',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Timer
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF333333),
                        ),
                        children: [
                          const TextSpan(text: 'Time remaining: '),
                          TextSpan(
                            text: _formattedTime,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1173D4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Bottom buttons
              Column(
                children: [
                  // Resend Code button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _remainingSeconds = 120;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: const Color(0xFF1173D4),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Resend Code',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Cancel Payment button
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Cancel Payment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF617589),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
