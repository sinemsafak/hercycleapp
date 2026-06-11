import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    animationController.forward();

    Future.delayed(const Duration(seconds: 8), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6EC),
      body: Stack(
        children: [
          const Positioned(
            top: -90,
            right: -80,
            child: _BlurCircle(
              size: 230,
              color: Color(0xFFE2EEDB),
            ),
          ),
          const Positioned(
            bottom: -110,
            left: -80,
            child: _BlurCircle(
              size: 260,
              color: Color(0xFFDDECCF),
            ),
          ),
          const Positioned(
            top: 110,
            left: 28,
            child: _FloatingIcon(
              icon: Icons.eco_rounded,
              angle: -0.35,
              size: 34,
            ),
          ),
          const Positioned(
            bottom: 145,
            right: 32,
            child: _FloatingIcon(
              icon: Icons.spa_rounded,
              angle: 0.45,
              size: 30,
            ),
          ),

          Center(
            child: FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: slideAnimation,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 154,
                          height: 154,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.92),
                            borderRadius: BorderRadius.circular(42),
                            border: Border.all(
                              color: const Color(0xFFE5DECD),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 28,
                                offset: const Offset(0, 14),
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(0.8),
                                blurRadius: 12,
                                offset: const Offset(-4, -4),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/hercycle_logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(height: 28),

                        const Text(
                          'HERCYCLE AI',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF143D22),
                            letterSpacing: 1,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Döngüsel moda için akıllı üretim asistanı',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF5F6F62),
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 34),

                        Container(
                          width: 150,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 11,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.86),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color(0xFFE5DECD),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.4,
                                  color: Color(0xFF2E7D32),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Yükleniyor',
                                style: TextStyle(
                                  color: Color(0xFF143D22),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

class _BlurCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _BlurCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.72),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _FloatingIcon extends StatelessWidget {
  final IconData icon;
  final double angle;
  final double size;

  const _FloatingIcon({
    required this.icon,
    required this.angle,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Icon(
        icon,
        size: size,
        color: const Color(0xFF2E7D32).withOpacity(0.26),
      ),
    );
  }
}