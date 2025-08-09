import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import '../../../auth/presentation/screens/design_selector.dart';

class StepperInstitutional extends StatefulWidget {
  const StepperInstitutional({Key? key}) : super(key: key);

  @override
  State<StepperInstitutional> createState() => _StepperInstitutionalState();
}

class _StepperInstitutionalState extends State<StepperInstitutional>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _progressController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _progressAnimation;

  int _currentStep = 0;
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> _steps = [
    {
      'title': 'Épreuves disponibles',
      'description': 'Accédez à une vaste bibliothèque d\'examens prêts',
      'icon': Icons.edit_note,
      'color': const Color(0xFF3B82F6),
      'features': [
        'Milliers d\'épreuves',
        'Tous niveaux scolaires',
        'Matières variées',
        'Mise à jour régulière',
      ],
      'image': '📚',
    },
    {
      'title': 'Corrections fournies',
      'description': 'Corrections détaillées avec explications complètes',
      'icon': Icons.psychology,
      'color': const Color(0xFF10B981),
      'features': [
        'Corrigés détaillés',
        'Explications claires',
        'Barèmes fournis',
        'Solutions multiples',
      ],
      'image': '✅',
    },
    {
      'title': 'Paiement de scolarité',
      'description': 'Gestion complète des frais scolaires et paiements',
      'icon': Icons.payment,
      'color': const Color(0xFF8B5CF6),
      'features': [
        'Paiements sécurisés',
        'Échéanciers flexibles',
        'Factures automatiques',
        'Suivi des paiements',
      ],
      'image': '💳',
    },
  ];

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      _fadeController.forward();
      _progressController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _progressController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
      _progressController.reset();
      _progressController.forward();
    } else {
      _navigateToSuccess();
    }
    HapticFeedback.lightImpact();
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
      _progressController.reset();
      _progressController.forward();
    }
    HapticFeedback.lightImpact();
  }

  void _navigateToSuccess() {
    HapticFeedback.lightImpact();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, _) => const HomePage(),
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.5,
                colors: [
                  const Color.fromARGB(255, 255, 255, 255),
                  // const Color.fromARGB(255, 255, 255, 255),
                  const Color.fromARGB(255, 225, 234, 255),
                ],
              ),
            ),
          ),

          // Floating geometric shapes
          _buildFloatingShapes(),

          // Main content
          SafeArea(
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _slideAnimation.value),
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Column(
                      children: [
                        // Header
                        _buildHeader(),

                        // Progress indicator
                        _buildProgressIndicator(),

                        // Content
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentStep = index;
                              });
                              _progressController.reset();
                              _progressController.forward();
                            },
                            itemCount: _steps.length,
                            itemBuilder: (context, index) {
                              return _buildStepContent(_steps[index]);
                            },
                          ),
                        ),

                        // Navigation buttons
                        _buildNavigationButtons(),
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

  Widget _buildFloatingShapes() {
    return Positioned.fill(
      child: CustomPaint(painter: FloatingShapesPainter()),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Logo/Brand
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.school, color: Colors.white, size: 28),
          ),

          const SizedBox(height: 20),

          // Title
          const Text(
            'Wiilloo',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              letterSpacing: -1,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'L\'éducation redéfinie',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: List.generate(_steps.length, (index) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: index < _steps.length - 1 ? 8 : 0),
              height: 4,
              decoration: BoxDecoration(
                color: index <= _currentStep
                    ? _steps[_currentStep]['color']
                    : Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent(Map<String, dynamic> step) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 40),

          // Large emoji/image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: step['color'].withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: step['color'].withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(step['image'], style: const TextStyle(fontSize: 48)),
            ),
          ),

          const SizedBox(height: 40),

          // Title
          Text(
            step['title'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            step['description'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black.withOpacity(0.8),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 48),

          // Features grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: step['features'].length,
            itemBuilder: (context, index) {
              return _buildFeatureCard(step['features'][index], step['color']);
            },
          ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String feature, Color color) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + (_progressAnimation.value * 0.2),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.3), width: 1),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 18),
                ),
                const SizedBox(height: 12),
                Text(
                  feature,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(1),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          // Previous button
          if (_currentStep > 0)
            Expanded(
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: TextButton(
                  onPressed: _previousStep,
                  child: const Text(
                    'Précédent',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

          if (_currentStep > 0) const SizedBox(width: 16),

          // Next/Finish button
          Expanded(
            flex: _currentStep == 0 ? 1 : 1,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _steps[_currentStep]['color'],
                    _steps[_currentStep]['color'].withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _steps[_currentStep]['color'].withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: _nextStep,
                child: Text(
                  _currentStep == _steps.length - 1 ? 'Commencer' : 'Suivant',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Floating circles
    for (int i = 0; i < 8; i++) {
      paint.color = [
        const Color(0xFF3B82F6).withOpacity(0.05),
        const Color(0xFF10B981).withOpacity(0.05),
        const Color(0xFF8B5CF6).withOpacity(0.05),
      ][i % 3];

      final x = (size.width / 4) * (i % 3) + (i * 30);
      final y = (size.height / 6) * (i % 4) + (i * 50);
      final radius = 20 + (i % 3) * 15;

      canvas.drawCircle(
        Offset(x % size.width, y % size.height),
        radius.toDouble(),
        paint,
      );
    }

    // Geometric shapes
    final shapePaint = Paint()
      ..color = const Color(0xFF3B82F6).withOpacity(0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw hexagons
    for (int i = 0; i < 3; i++) {
      final center = Offset(
        size.width * (0.2 + i * 0.3),
        size.height * (0.1 + i * 0.25),
      );
      _drawHexagon(canvas, center, 40, shapePaint);
    }
  }

  void _drawHexagon(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60) * (math.pi / 180);
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
