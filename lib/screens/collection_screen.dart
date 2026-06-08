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

 String getImageUrl(String product) {
  final Map<String, String> imageUrls = {
    'Sports Bag':
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800',
    'Gym Accessory':
        'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=800',
    'Headband':
        'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=800',
    'Tote Bag':
        'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=800',
    'Mini Backpack':
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800',
    'Accessory Pouch':
        'https://images.unsplash.com/photo-1594223274512-ad4803739b7c?w=800',
    'Scarf':
        'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=800',
    'Summer Blouse':
        'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?w=800',
    'Kimono':
        'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=800',
    'Patchwork Jacket':
        'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=800',
    'Mini Skirt':
        'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=800',
    'Fashion Bag':
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800',
  };

  return imageUrls[product] ??
      'https://images.unsplash.com/photo-1496747611176-843222e1e57c?w=800';
}

  String getProductDescription(String product) {
    switch (product) {
      case 'Sports Bag':
        return 'Esnek ve dayanıklı kumaştan üretilebilecek spor çantası önerisi.';
      case 'Gym Accessory':
        return 'Küçük kumaş parçalarından üretilebilecek spor aksesuarı.';
      case 'Headband':
        return 'Esnek kumaş firelerinden yapılabilecek saç bandı.';
      case 'Tote Bag':
        return 'Günlük kullanım için dayanıklı ileri dönüşüm çantası.';
      case 'Mini Backpack':
        return 'Küçük kumaş parçalarıyla üretilebilecek sırt çantası.';
      case 'Accessory Pouch':
        return 'Küçük fire kumaşlardan yapılabilecek aksesuar kesesi.';
      case 'Scarf':
        return 'Hafif kumaşlardan üretilebilecek şal önerisi.';
      case 'Summer Blouse':
        return 'İnce kumaştan yapılabilecek yazlık bluz.';
      case 'Kimono':
        return 'Dökümlü kumaşlardan üretilebilecek kimono.';
      case 'Patchwork Jacket':
        return 'Parça kumaşların birleşimiyle üretilebilecek özel tasarım ceket.';
      case 'Mini Skirt':
        return 'Orta boy kumaş parçalarından üretilebilecek modern etek.';
      case 'Fashion Bag':
        return 'Moda odaklı ileri dönüşüm çanta önerisi.';
      default:
        return 'Bu ürün, eldeki kumaşın yeniden değerlendirilmesi için önerilmiştir.';
    }
  }

  void showProductDetail(BuildContext context, String product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.network(
                  getImageUrl(product),
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      height: 190,
                      color: const Color(0xFFE2EEDB),
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 48,
                        color: Color(0xFF2E7D32),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              Text(
                product,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF143D22),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                getProductDescription(product),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54, height: 1.5),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = recommendedProducts.isNotEmpty
        ? recommendedProducts
        : ['Tote Bag', 'Patchwork Jacket', 'Mini Skirt'];

    return Scaffold(
      appBar: AppBar(title: const Text('HERCYCLE Koleksiyonu')),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$material kumaştan\nneler üretebilirsin?',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF143D22),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () => showProductDetail(context, product),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(22),
                            ),
                            child: Image.network(
                              getImageUrl(product),
                              height: 130,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) {
                                return Container(
                                  height: 130,
                                  color: const Color(0xFFE2EEDB),
                                  child: const Center(
                                    child: Icon(
                                      Icons.eco,
                                      size: 42,
                                      color: Color(0xFF2E7D32),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Color(0xFFE2EEDB),
                                  child: Icon(
                                    Icons.eco,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        getProductDescription(product),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios, size: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            AppButton(
              text: 'Etkiyi Gör',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ImpactScreen(
                      material: material,
                      productCount: products.length,
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