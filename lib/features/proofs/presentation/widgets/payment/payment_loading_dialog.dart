import 'package:flutter/material.dart';

class PaymentLoadingDialog extends StatelessWidget {
  final String paymentMethod;

  const PaymentLoadingDialog({
    Key? key,
    required this.paymentMethod,
  }) : super(key: key);

  String get _title {
    switch (paymentMethod) {
      case 'credit-card':
        return 'Processing Payment...';
      case 'mobile-money':
        return 'Initiating Mobile Money...';
      case 'orange-money':
        return 'Initiating Orange Money...';
      default:
        return 'Processing...';
    }
  }

  IconData get _icon {
    switch (paymentMethod) {
      case 'credit-card':
        return Icons.credit_card;
      case 'mobile-money':
      case 'orange-money':
        return Icons.smartphone;
      default:
        return Icons.payment;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated loading indicator
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color(0xFF1173D4),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [const Color(0xFF1173D4), const Color(0xFF0EA5E9)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _icon,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Title
            Text(
              _title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            
            // Subtitle
            const Text(
              'Please wait a moment.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
