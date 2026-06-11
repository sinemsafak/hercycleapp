import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import 'home_screen.dart';

class ImpactScreen extends StatelessWidget {
  final String? material;
  final int? productCount;

  const ImpactScreen({super.key, this.material, this.productCount});

  @override
  Widget build(BuildContext context) {
    final String shownMaterial = material ?? 'Kumaş';
    final int shownProductCount = productCount ?? 3;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6EC),
      appBar: AppBar(
        title: const Text('Etki Rozeti'),
        backgroundColor: const Color(0xFFF8F6EC),
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(22, 28, 22, 26),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.78),
                    borderRadius: BorderRadius.circular(34),
                    border: Border.all(color: const Color(0xFFE5DECD)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Tebrikler! 🌿',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF143D22),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const SizedBox(height: 28),

                      Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32),
                          borderRadius: BorderRadius.circular(44),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2E7D32).withOpacity(0.28),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 22,
                              right: 24,
                              child: Icon(
                                Icons.eco_rounded,
                                size: 70,
                                color: Colors.white.withOpacity(0.12),
                              ),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.eco_rounded,
                                  size: 54,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 14),
                                Text(
                                  'Döngüsel\nÜretici Rozeti',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    height: 1.25,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      const Row(
                        children: [
                          Expanded(
                            child: _ImpactMetric(
                              title: 'Kurtarılan Kumaş',
                              value: '2.4 kg',
                              icon: Icons.recycling_rounded,
                            ),
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: _ImpactMetric(
                              title: 'Etki Puanı',
                              value: '91 / 100',
                              icon: Icons.auto_awesome_rounded,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      const _MiniImpactInfo(
                        icon: Icons.co2_rounded,
                        title: 'Karbon Etkisi',
                        text: 'Yaklaşık 4.1 kg CO₂ salımı önlendi.',
                      ),

                      const SizedBox(height: 12),

                      const _MiniImpactInfo(
                        icon: Icons.groups_rounded,
                        title: 'Sosyal Katkı',
                        text:
                            'Kadın girişimcilerin sürdürülebilir üretimine destek sağlar.',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            AppButton(
              text: 'Ana Sayfaya Dön',
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ImpactMetric extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _ImpactMetric({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF8D8),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF2E7D32), size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 19,
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniImpactInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _MiniImpactInfo({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F6EC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5DECD)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFFE2EEDB),
            child: Icon(icon, color: const Color(0xFF2E7D32), size: 22),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF143D22),
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12.5,
                    height: 1.3,
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
