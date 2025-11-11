import 'package:flutter/material.dart';

class Step4Payment extends StatelessWidget {
  final Map<String, dynamic> formData;
  final Function(String, dynamic) onDataChanged;

  const Step4Payment({
    Key? key,
    required this.formData,
    required this.onDataChanged,
  }) : super(key: key);

  String _getPrice() {
    switch (formData['quality']) {
      case 'minimal':
        return '0 CFA';
      case 'standard':
        return '2,500 CFA';
      case 'premium':
        return '5,000 CFA';
      default:
        return '0 CFA';
    }
  }

  Widget _buildPaymentOption({
    required String value,
    required IconData icon,
    required String label,
  }) {
    final isSelected = formData['paymentMethod'] == value;
    
    return GestureDetector(
      onTap: () => onDataChanged('paymentMethod', value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xFF1173D4) : const Color(0xFFE2E8F0),
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: const Color(0xFF1173D4).withOpacity(0.2),
                blurRadius: 16,
                offset: const Offset(0, 4),
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [const Color(0xFF1173D4), const Color(0xFF0EA5E9)],
                      )
                    : LinearGradient(
                        colors: [const Color(0xFFF1F5F9), const Color(0xFFE2E8F0)],
                      ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: const Color(0xFF1173D4).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ] : null,
              ),
              child: Icon(
                icon,
                size: 26,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF475569),
                  letterSpacing: -0.2,
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF1173D4) : const Color(0xFFCBD5E1),
                  width: 2,
                ),
                color: isSelected ? const Color(0xFF1173D4) : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final price = _getPrice();
    final isFree = price == '0 CFA';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price Summary with modern design
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isFree 
                  ? [const Color(0xFFECFDF5), const Color(0xFFD1FAE5)]
                  : [const Color(0xFFEFF6FF), const Color(0xFFDBEAFE)],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isFree 
                  ? const Color(0xFFA7F3D0).withOpacity(0.5)
                  : const Color(0xFF93C5FD).withOpacity(0.5),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: (isFree ? const Color(0xFF10B981) : const Color(0xFF1173D4)).withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isFree
                                ? [const Color(0xFF10B981), const Color(0xFF059669)]
                                : [const Color(0xFF1173D4), const Color(0xFF0EA5E9)],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: (isFree ? const Color(0xFF10B981) : const Color(0xFF1173D4)).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          isFree ? Icons.check_circle : Icons.payment,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isFree
                        ? [const Color(0xFF10B981), const Color(0xFF059669)]
                        : [const Color(0xFF1173D4), const Color(0xFF0EA5E9)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: (isFree ? const Color(0xFF10B981) : const Color(0xFF1173D4)).withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  price,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        if (!isFree) ...[
          const Text(
            'Select a Payment Method',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          
          _buildPaymentOption(
            value: 'credit-card',
            icon: Icons.credit_card,
            label: 'Credit Card (CB)',
          ),
          _buildPaymentOption(
            value: 'mobile-money',
            icon: Icons.smartphone,
            label: 'Mobile Money (MoMo)',
          ),
          _buildPaymentOption(
            value: 'orange-money',
            icon: Icons.account_balance_wallet,
            label: 'Orange Money (OM)',
          ),
        ] else ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFA7F3D0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF10B981),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Free Service',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF065F46),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'You have selected the minimal quality option which is completely free. No payment is required.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF047857),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        
        const SizedBox(height: 24),
        
        // Terms and Conditions
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline,
                color: Color(0xFF92400E),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF78350F),
                    ),
                    children: [
                      TextSpan(
                        text: 'By submitting this request, you agree to our ',
                      ),
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' and ',
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
