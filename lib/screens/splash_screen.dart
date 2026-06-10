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

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );

    scaleAnimation = Tween<double>(
      begin: 0.88,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutBack,
      ),
    );

    animationController.forward();

    Future.delayed(const Duration(seconds: 3), () {
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
            top: -40,
            right: -30,
            child: _LeafDecoration(size: 150, opacity: 0.16),
          ),
          const Positioned(
            bottom: -30,
            left: -35,
            child: _LeafDecoration(size: 170, opacity: 0.18),
          ),
          const Positioned(
            top: 95,
            left: 28,
            child: _SmallLeaf(angle: -0.5),
          ),
          const Positioned(
            bottom: 120,
            right: 34,
            child: _SmallLeaf(angle: 0.7),
          ),
          Center(
            child: FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/hercycle_logo.png',
                        width: 170,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        'HERCYCLE AI',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF143D22),
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Kadın girişimciler için döngüsel moda asistanı',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF5F6F62),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const SizedBox(
                        width: 42,
                        child: LinearProgressIndicator(
                          minHeight: 4,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xFF2E7D32),
                          backgroundColor: Color(0xFFDDE8D5),
                        ),
                      ),
                    ],
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

class _LeafDecoration extends StatelessWidget {
  final double size;
  final double opacity;

  const _LeafDecoration({
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Icon(
        Icons.eco_rounded,
        size: size,
        color: const Color(0xFF2E7D32),
      ),
    );
  }
}

class _SmallLeaf extends StatelessWidget {
  final double angle;

  const _SmallLeaf({required this.angle});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: const Icon(
        Icons.spa_rounded,
        size: 34,
        color: Color(0xFF8CBF72),
      ),
    );
  }
}