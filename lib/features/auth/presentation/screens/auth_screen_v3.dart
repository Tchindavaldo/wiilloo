import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'stepper_institutional.dart';

class AuthScreenV3 extends StatefulWidget {
  const AuthScreenV3({Key? key}) : super(key: key);

  @override
  State<AuthScreenV3> createState() => _AuthScreenV3State();
}

class _AuthScreenV3State extends State<AuthScreenV3>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    HapticFeedback.selectionClick();
    _navigateToPresentation();
  }

  void _navigateToPresentation() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, _) => const StepperInstitutional(),
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          // Background geometric pattern
          _buildBackgroundPattern(screenWidth, screenHeight),

          // Main content
          SafeArea(
            child: AnimatedBuilder(
              animation: _slideAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _slideAnimation.value * 50),
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Column(
                      children: [
                        // Header section
                        Expanded(flex: 3, child: _buildHeaderSection()),

                        // Auth section
                        Expanded(flex: 2, child: _buildAuthSection()),

                        // Bottom section
                        _buildBottomSection(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundPattern(double width, double height) {
    return Positioned.fill(
      child: CustomPaint(
        painter: GeometricPatternPainter(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color.fromARGB(220, 255, 255, 255),
                // const Color.fromARGB(255, 255, 255, 255),
                const Color.fromARGB(255, 225, 234, 255),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Institutional badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF3B82F6).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.verified_outlined,
                  size: 16,
                  color: Color(0xFF3B82F6),
                ),
                const SizedBox(width: 8),
                Text(
                  'Certified Platform',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF3B82F6).withOpacity(0.9),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Main title with modern typography
          const Text(
            'Academic\nExcellence',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w300,
              color: Colors.black,
              height: 1.0,
              letterSpacing: -1.5,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Redefined',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Color(0xFF06B6D4),
              height: 1.0,
              letterSpacing: -1.5,
            ),
          ),

          const SizedBox(height: 24),

          // Subtitle with educational focus
          Text(
            'Advanced assessment tools for modern education.\nEmpowering educators, inspiring students.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.7),
              height: 1.5,
              letterSpacing: 0.2,
            ),
          ),

          const SizedBox(height: 40),

          // Key features indicators
          _buildFeatureIndicators(),
        ],
      ),
    );
  }

  Widget _buildFeatureIndicators() {
    return Row(
      children: [
        _buildIndicator('AI-Powered', Icons.psychology_outlined),
        const SizedBox(width: 24),
        _buildIndicator('Secure', Icons.security_outlined),
        const SizedBox(width: 24),
        _buildIndicator('Real-time', Icons.flash_on_outlined),
      ],
    );
  }

  Widget _buildIndicator(String label, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFF06B6D4).withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 12, color: const Color(0xFF06B6D4)),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.8),
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildAuthSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Section title
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Choose your path',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.9),
                letterSpacing: 0.3,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Google Auth Button
          _buildAuthButton(
            icon: _buildGoogleIcon(),
            text: 'Continuer avec Google',
            onTap: _navigateToLogin,
            isPrimary: true,
          ),

          const SizedBox(height: 16),

          // Apple Auth Button
          _buildAuthButton(
            icon: const Icon(Icons.apple, color: Colors.white, size: 20),
            text: 'Continuer avec Apple',
            onTap: _navigateToLogin,
            isPrimary: false,
          ),

          const SizedBox(height: 16),

          // WhatsApp Auth Button
          _buildAuthButton(
            icon: const Icon(Icons.chat, color: Colors.white, size: 20),
            text: 'Connexion via WhatsApp',
            onTap: _navigateToLogin,
            isPrimary: false,
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4285F4),
            Color(0xFF34A853),
            Color(0xFFFBBC05),
            Color(0xFFEA4335),
          ],
        ),
      ),
      child: const Center(
        child: Text(
          'G',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButton({
    required Widget icon,
    required String text,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: isPrimary ? Colors.white : const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(12),
          border: isPrimary
              ? null
              : Border.all(color: const Color(0xFF334155), width: 1),
          boxShadow: [
            if (isPrimary)
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isPrimary ? const Color(0xFF1F2937) : Colors.white,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          // Terms and privacy
          Text(
            'By continuing, you agree to our Terms of Service\nand Privacy Policy',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.5),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 16),

          // Educational partnership badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF059669).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF059669).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.school_outlined,
                  size: 14,
                  color: Color(0xFF059669),
                ),
                const SizedBox(width: 6),
                Text(
                  'Trusted by 500+ institutions',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF059669).withOpacity(0.9),
                    letterSpacing: 0.3,
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

class GeometricPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E293B).withOpacity(0.1)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    // Draw subtle geometric grid
    for (double i = 0; i < size.width; i += 60) {
      for (double j = 0; j < size.height; j += 60) {
        canvas.drawCircle(Offset(i, j), 20, paint);
      }
    }

    // Draw diagonal lines
    final linePaint = Paint()
      ..color = const Color.fromARGB(150, 255, 255, 255)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (double i = -size.height; i < size.width; i += 100) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
