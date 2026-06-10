import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentPage = 0;

  final pages = const [
    _OnboardingPage(
      icon: Icons.recycling,
      title: 'Atık kumaşları\nyeni değerlere dönüştür.',
      subtitle: 'Sürdürülebilir üretim için akıllı öneriler al.',
    ),
    _OnboardingPage(
      icon: Icons.checklist_rounded,
      title: 'HERCYCLE AI\nnasıl çalışır?',
      subtitle: 'Kumaşı yükle, AI analiz etsin, ürün önerisi al.',
    ),
    _OnboardingPage(
      icon: Icons.groups_rounded,
      title: 'Kadın girişimciler için\nakıllı üretim desteği.',
      subtitle: 'Üretimini dönüştür, destek al, etkini dünyaya göster.',
    ),
  ];

  void nextPage() {
    if (currentPage == pages.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RegisterScreen()),
      );
    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
                children: pages,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentPage == index ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? const Color(0xFF2E7D32)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              text: currentPage == pages.length - 1 ? 'Başla' : 'Devam Et',
              onPressed: nextPage,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 120, color: const Color(0xFF2E7D32)),
        const SizedBox(height: 36),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF143D22),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: Color(0xFF647067)),
        ),
      ],
    );
  }
}