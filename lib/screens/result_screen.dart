import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import 'collection_screen.dart';

class ResultScreen extends StatelessWidget {
  final String material;
  final double confidence;
  final int trendScore;
  final List<String> recommendedProducts;

  const ResultScreen({
    super.key,
    required this.material,
    required this.confidence,
    required this.trendScore,
    required this.recommendedProducts,
  });

  @override
  Widget build(BuildContext context) {
    final confidencePercent = (confidence * 100).toStringAsFixed(1);

    return Scaffold(
      appBar: AppBar(title: const Text('Analiz Sonucu')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$material Algılandı',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 18),

            Container(
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFFCFD9C5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(
                child: Icon(
                  Icons.texture,
                  size: 80,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Model Güveni',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 8),

            Text(
              '%$confidencePercent',
              style: const TextStyle(
                fontSize: 34,
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Trend Skoru',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Text(
                  '$trendScore',
                  style: const TextStyle(
                    fontSize: 42,
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(' / 100'),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'En uygun ürün',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 8),

            Text(
              recommendedProducts.isNotEmpty
                  ? recommendedProducts.first
                  : 'Öneri bulunamadı',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const Spacer(),

            AppButton(
              text: 'Koleksiyon Önerilerini Gör',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CollectionScreen(
                      material: material,
                      recommendedProducts: recommendedProducts,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}