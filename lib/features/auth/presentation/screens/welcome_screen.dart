import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'stepper_institutional.dart';
import 'stepper_personal.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<double>(
      begin: 30.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
    ));

    Future.delayed(const Duration(milliseconds: 300), () {
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    HapticFeedback.selectionClick();
    _navigateToInstitutionalStepper();
  }

  void _navigateToInstitutionalStepper() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, _) => const StepperInstitutional(),
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToPersonalStepper() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, _) => const StepperPersonal(),
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              const SizedBox(height: 80),

              // Header Section
              Expanded(
                flex: 2,
                child: AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Logo/Brand Area
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.assessment_outlined,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),

                            const SizedBox(height: 48),

                            // Main Title
                            const Text(
                              'Professional\nAssessment\nPlatform',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF1A1A1A),
                                height: 1.1,
                                letterSpacing: -0.5,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Subtitle
                            const Text(
                              'Streamline your examination process\nwith precision and reliability',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF6B7280),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Feature Section
              Expanded(
                flex: 2,
                child: AnimatedBuilder(
                  animation: _fadeController,
                  builder: (context, child) {
                    final staggeredAnimation = Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(CurvedAnimation(
                      parent: _fadeController,
                      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
                    ));

                    return Transform.translate(
                      offset: Offset(0, (1 - staggeredAnimation.value) * 20),
                      child: Opacity(
                        opacity: staggeredAnimation.value,
                        child: Column(
                          children: [
                            _buildFeatureItem(
                              icon: Icons.security_outlined,
                              title: 'Secure & Compliant',
                              description: 'Enterprise-grade security for sensitive data',
                            ),

                            const SizedBox(height: 32),

                            _buildFeatureItem(
                              icon: Icons.analytics_outlined,
                              title: 'Advanced Analytics',
                              description: 'Comprehensive insights and reporting tools',
                            ),

                            const SizedBox(height: 32),

                            _buildFeatureItem(
                              icon: Icons.speed_outlined,
                              title: 'Streamlined Workflow',
                              description: 'Efficient processes for optimal productivity',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // CTA Section
              Expanded(
                flex: 1,
                child: AnimatedBuilder(
                  animation: _fadeController,
                  builder: (context, child) {
                    final ctaAnimation = Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(CurvedAnimation(
                      parent: _fadeController,
                      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
                    ));

                    return Transform.translate(
                      offset: Offset(0, (1 - ctaAnimation.value) * 15),
                      child: Opacity(
                        opacity: ctaAnimation.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Primary CTA
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: _navigateToLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1A1A1A),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Get Started',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Secondary CTA
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: OutlinedButton(
                                onPressed: _navigateToLogin,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF1A1A1A),
                                  side: const BorderSide(
                                    color: Color(0xFFE5E7EB),
                                    width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Learn More',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFF374151),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
