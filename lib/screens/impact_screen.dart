import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import 'home_screen.dart';

class ImpactScreen extends StatelessWidget {
  final String? material;
  final int? productCount;

  const ImpactScreen({
    super.key,
    this.material,
    this.productCount,
  });

  @override
  Widget build(BuildContext context) {
    final String shownMaterial = material ?? 'Kumaş';
    final int shownProductCount = productCount ?? 3;

    return Scaffold(
      appBar: AppBar(title: const Text('Etki Rozeti')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),

            const Text(
              'Tebrikler! 🌿',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF143D22),
              ),
            ),

            const SizedBox(height: 32),

            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32),
                borderRadius: BorderRadius.circular(42),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.eco, size: 58, color: Colors.white),
                  SizedBox(height: 14),
                  Text(
                    'Döngüsel\nÜretici Rozeti',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 36),

            Text(
              '$shownMaterial kumaşı için $shownProductCount ürün önerisi oluşturuldu.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 34),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ImpactValue(
                  title: 'Kurtarılan Kumaş',
                  value: '2.4 kg',
                ),
                _ImpactValue(
                  title: 'Etki Puanı',
                  value: '91 / 100',
                ),
              ],
            ),

            const SizedBox(height: 28),

            const _ImpactCard(
              icon: Icons.co2,
              title: 'Karbon Etkisi',
              value: 'Yaklaşık 4.1 kg CO₂ salımı önlendi.',
            ),

            const SizedBox(height: 14),

            const _ImpactCard(
              icon: Icons.groups_rounded,
              title: 'Kadın Girişimci Desteği',
              value: 'Bu üretim modeli kadın girişimcilerin sürdürülebilir üretimine katkı sağlar.',
            ),

            const Spacer(),

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

class _ImpactValue extends StatelessWidget {
  final String title;
  final String value;

  const _ImpactValue({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ImpactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ImpactCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFE2EEDB),
            child: Icon(icon, color: const Color(0xFF2E7D32)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
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