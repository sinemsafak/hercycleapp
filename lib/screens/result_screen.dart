import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import 'collection_screen.dart';

class ResultScreen extends StatelessWidget {
  final File imageFile;
  final String material;
  final double confidence;
  final int trendScore;
  final List<String> recommendedProducts;

  const ResultScreen({
    super.key,
    required this.imageFile,
    required this.material,
    required this.confidence,
    required this.trendScore,
    required this.recommendedProducts,
  });

  String getMaterialDescription(String material) {
    switch (material) {
      case 'Spandex':
        return 'Esnek yapısı sayesinde spor aksesuarları ve küçük çantalar için uygundur.';
      case 'Polyester':
        return 'Dayanıklı yapısıyla çanta, aksesuar ve günlük kullanım ürünleri için uygundur.';
      case 'Chiffon':
        return 'Hafif ve dökümlü yapısıyla şal, bluz ve kimono gibi ürünlere uygundur.';
      case 'Polyester Spandex':
        return 'Hem esnek hem dayanıklı yapısıyla modern koleksiyon parçalarına uygundur.';
      default:
        return 'Bu kumaş ileri dönüşüm ürünleri için değerlendirilebilir.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final confidencePercent = (confidence * 100).toStringAsFixed(1);

    return Scaffold(
      appBar: AppBar(title: const Text('Analiz Sonucu')),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$material Algılandı',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF143D22),
              ),
            ),
            const SizedBox(height: 18),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE1ECD9),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.file(
                      imageFile,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    material,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF143D22),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    getMaterialDescription(material),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _InfoRow(title: 'Model Güveni', value: '%$confidencePercent'),
            const SizedBox(height: 18),
            _InfoRow(title: 'Trend Skoru', value: '$trendScore / 100'),

            const SizedBox(height: 22),

            const Text(
              'En uygun ürün',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(
              recommendedProducts.isNotEmpty
                  ? recommendedProducts.first
                  : 'Öneri bulunamadı',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF143D22),
              ),
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

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.black54)),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
      ],
    );
  }
}