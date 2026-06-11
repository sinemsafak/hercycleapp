import 'package:flutter/material.dart';

import 'upload_screen.dart';
import 'chatbot_screen.dart';
import 'impact_screen.dart';
import 'trend_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const cream = Color(0xFFF8F6EC);
  static const darkGreen = Color(0xFF143D22);
  static const green = Color(0xFF2E7D32);
  static const softGreen = Color(0xFFEFF8D8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 36, 18, 10),
          child: Column(
            children: [
              const Spacer(flex: 1),

              const _Header(),

              const SizedBox(height: 18),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.92,
                children: [
                  _HomeCard(
                    title: 'Kumaş Analizi',
                    subtitle: 'Fotoğraf yükle',
                    icon: Icons.camera_alt_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const UploadScreen(),
                        ),
                      );
                    },
                  ),
                  _HomeCard(
                    title: 'Trend Önerileri',
                    subtitle: 'Güncel fikirleri gör',
                    icon: Icons.trending_up_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TrendScreen(),
                        ),
                      );
                    },
                  ),
                  _HomeCard(
                    title: 'Etki Raporu',
                    subtitle: 'Üretiminin çevresel etkisi',
                    icon: Icons.eco_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ImpactScreen(),
                        ),
                      );
                    },
                  ),
                  _HomeCard(
                    title: 'Destek Chatbotu',
                    subtitle: 'Hera ile konuş',
                    icon: Icons.chat_bubble_outline_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChatbotScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const Spacer(flex: 2),

              const _BottomNav(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/hercycle_logo.png',
          width: 46,
          height: 46,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Merhaba, 👋',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  color: HomeScreen.darkGreen,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Bugün ne yapmak istersin?',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            size: 21,
            color: HomeScreen.darkGreen,
          ),
        ),
      ],
    );
  }
}

class _HomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _HomeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(26),
      child: InkWell(
        borderRadius: BorderRadius.circular(26),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: const Color(0xFFE5DECD)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.14),
                blurRadius: 22,
                spreadRadius: 1,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.9),
                blurRadius: 8,
                offset: const Offset(-3, -3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: HomeScreen.softGreen,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: HomeScreen.green.withOpacity(0.18),
                      blurRadius: 14,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: HomeScreen.green,
                  size: 40,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: HomeScreen.darkGreen,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Colors.black54,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFFE5DECD)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.home_rounded, label: 'Ana Sayfa', active: true),
          _NavItem(icon: Icons.trending_up_rounded, label: 'Analiz'),
          _NavItem(icon: Icons.chat_bubble_outline_rounded, label: 'Chat'),
          _NavItem(icon: Icons.person_outline_rounded, label: 'Profil'),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 62,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 21,
            color: active ? HomeScreen.green : Colors.black38,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: active ? FontWeight.w800 : FontWeight.w500,
              color: active ? HomeScreen.green : Colors.black38,
            ),
          ),
        ],
      ),
    );
  }
}