import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import 'register_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentPage = 0;

  void nextPage() {
    if (currentPage == 2) {
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
    const pages = [_FirstPage(), _HowItWorksPage(), _ThirdPage()];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6EC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
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
              _Dots(currentPage: currentPage),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: AppButton(
                  text: currentPage == 2 ? 'Başla' : 'Devam Et',
                  onPressed: nextPage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FirstPage extends StatelessWidget {
  const _FirstPage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.65),
                borderRadius: BorderRadius.circular(34),
              ),
              padding: const EdgeInsets.all(18),
              child: Image.asset(
                'assets/images/onboarding_1.png',
                height: 285,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 34),
            const Text(
              'Atık kumaşları yeni değerlere dönüştür.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                height: 1.14,
                fontWeight: FontWeight.w900,
                color: Color(0xFF143D22),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Sürdürülebilir bir gelecek için\nbirlikte üretelim.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.45,
                color: Color(0xFF6A756C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HowItWorksPage extends StatelessWidget {
  const _HowItWorksPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 42, bottom: 30),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 42),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFE4E7DC)),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'HERCYCLE AI\nnasıl çalışır?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 29,
              height: 1.18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF143D22),
            ),
          ),
          SizedBox(height: 50),
          _StepItem(
            number: '1',
            title: 'Kumaşı yükle',
            subtitle: 'Atık kumaş fotoğrafını ekle.',
          ),
          _StepDivider(),
          _StepItem(
            number: '2',
            title: 'AI analiz etsin',
            subtitle: 'Materyal, desen ve trendi belirlesin.',
          ),
          _StepDivider(),
          _StepItem(
            number: '3',
            title: 'Ürün önerisi al',
            subtitle: 'Sana özel sürdürülebilir ürün önerileri sunulsun.',
          ),
        ],
      ),
    );
  }
}

class _ThirdPage extends StatelessWidget {
  const _ThirdPage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          'assets/images/onboarding_2.png',
          height: 245,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 28),
        const Text(
          'Kadın girişimciler için\nakıllı üretim desteği.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 29,
            height: 1.18,
            fontWeight: FontWeight.w900,
            color: Color(0xFF143D22),
          ),
        ),
        const SizedBox(height: 34),
        const _FeatureItem(
          icon: Icons.person_add_alt_1_rounded,
          text: 'Üretimini dönüştür',
        ),
        const _FeatureItem(
          icon: Icons.psychology_rounded,
          text: 'AI ile doğru karar ver',
        ),
        const _FeatureItem(
          icon: Icons.volunteer_activism_rounded,
          text: 'Destek al, güçlen',
        ),
        const _FeatureItem(
          icon: Icons.public_rounded,
          text: 'Etkini dünyaya göster',
        ),
        const Spacer(),
      ],
    );
  }
}

class _StepItem extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;

  const _StepItem({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: const Color(0xFF2E7D32),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF143D22),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6A756C),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StepDivider extends StatelessWidget {
  const _StepDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, top: 20, bottom: 20),
      height: 1,
      color: Color(0xFFE4E7DC),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFE2EEDB),
            child: Icon(
              icon,
              size: 19,
              color: const Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle(
              fontSize: 17,
              color: Color(0xFF143D22),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int currentPage;

  const _Dots({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 18 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: currentPage == index
                ? const Color(0xFF2E7D32)
                : const Color(0xFFD6DDCF),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}