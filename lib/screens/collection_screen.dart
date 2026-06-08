import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import 'impact_screen.dart';

class CollectionScreen extends StatelessWidget {
  final String material;
  final List<String> recommendedProducts;

  const CollectionScreen({
    super.key,
    required this.material,
    required this.recommendedProducts,
  });

  @override
  Widget build(BuildContext context) {
    final products = recommendedProducts.isNotEmpty
        ? recommendedProducts
        : ['Tote Bag', 'Patchwork Jacket', 'Mini Skirt'];

    return Scaffold(
      appBar: AppBar(title: const Text('HERCYCLE Collection')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$material kumaştan\nneler üretebilirsin?',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            ...products.map(
              (product) => Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color(0xFFE2EEDB),
                      child: Icon(Icons.eco, color: Color(0xFF2E7D32)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        product,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),

            const Spacer(),

            AppButton(
              text: 'Etkiyi Gör',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ImpactScreen(),
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