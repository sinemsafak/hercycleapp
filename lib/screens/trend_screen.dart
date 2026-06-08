import 'package:flutter/material.dart';

class TrendScreen extends StatelessWidget {
  const TrendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trends = [
      {
        'title': 'Tote Bag',
        'material': 'Polyester / Denim',
        'score': '92',
        'reason': 'Günlük kullanım ve sürdürülebilir çanta trendi yükselişte.',
        'icon': Icons.shopping_bag_rounded,
      },
      {
        'title': 'Patchwork Jacket',
        'material': 'Polyester Spandex',
        'score': '87',
        'reason': 'Parça kumaşlarla üretilebildiği için ileri dönüşüme uygun.',
        'icon': Icons.checkroom_rounded,
      },
      {
        'title': 'Headband',
        'material': 'Spandex',
        'score': '81',
        'reason': 'Küçük kumaş firelerinden üretilebildiği için fire azaltır.',
        'icon': Icons.spa_rounded,
      },
      {
        'title': 'Scarf',
        'material': 'Chiffon',
        'score': '78',
        'reason': 'Hafif kumaşlarda düşük maliyetli üretim fırsatı sunar.',
        'icon': Icons.style_rounded,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trend Önerileri'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bu hafta öne çıkan\nileri dönüşüm ürünleri',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF143D22),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Trend skoru; ürün popülerliği, üretim kolaylığı ve sürdürülebilirlik etkisine göre hesaplanır.',
              style: TextStyle(
                color: Colors.black54,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: ListView.builder(
                itemCount: trends.length,
                itemBuilder: (context, index) {
                  final trend = trends[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: const Color(0xFFE2EEDB),
                          child: Icon(
                            trend['icon'] as IconData,
                            color: const Color(0xFF2E7D32),
                          ),
                        ),
                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trend['title'] as String,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF143D22),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Uygun kumaş: ${trend['material']}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                trend['reason'] as String,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        Column(
                          children: [
                            Text(
                              trend['score'] as String,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                            const Text(
                              '/100',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}