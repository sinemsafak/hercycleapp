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

  String getTurkishMaterialName(String material) {
    switch (material) {
      case 'Spandex':
        return 'Elastan';
      case 'Polyester':
        return 'Polyester';
      case 'Chiffon':
        return 'Şifon';
      case 'Polyester Spandex':
        return 'Polyester Elastan';
      default:
        return material;
    }
  }

  String getTurkishProductName(String product) {
    switch (product) {
      case 'Sports Bag':
        return 'Spor Çantası';
      case 'Gym Accessory':
        return 'Spor Aksesuarı';
      case 'Headband':
        return 'Saç Bandı';
      case 'Tote Bag':
        return 'Bez Çanta';
      case 'Mini Backpack':
        return 'Mini Sırt Çantası';
      case 'Accessory Pouch':
        return 'Aksesuar Kesesi';
      case 'Scarf':
        return 'Şal';
      case 'Summer Blouse':
        return 'Yazlık Bluz';
      case 'Kimono':
        return 'Kimono';
      case 'Patchwork Jacket':
        return 'Patchwork Ceket';
      case 'Mini Skirt':
        return 'Mini Etek';
      case 'Fashion Bag':
        return 'Moda Çantası';
      default:
        return product;
    }
  }

  String getImageUrl(String product) {
    final Map<String, String> imageUrls = {
      'Sports Bag':
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=900',
      'Gym Accessory':
          'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=900',
      'Headband':
          'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=900',
      'Tote Bag':
          'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=900',
      'Mini Backpack':
          'https://images.unsplash.com/photo-1622560480654-d96214fdc887?w=900',
      'Accessory Pouch':
          'https://images.unsplash.com/photo-1594223274512-ad4803739b7c?w=900',
      'Scarf':
          'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=900',
      'Summer Blouse':
          'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?w=900',
      'Kimono':
          'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=900',
      'Patchwork Jacket':
          'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=900',
      'Mini Skirt':
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=900',
      'Fashion Bag':
          'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=900',
    };

    return imageUrls[product] ??
        'https://images.unsplash.com/photo-1496747611176-843222e1e57c?w=900';
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

  Widget productImage(String product, double height) {
    return Image.network(
      getImageUrl(product),
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        return Container(
          height: height,
          color: const Color(0xFFE2EEDB),
          child: const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF2E7D32),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          width: double.infinity,
          color: const Color(0xFFE2EEDB),
          child: const Center(
            child: Icon(
              Icons.eco,
              size: 44,
              color: Color(0xFF2E7D32),
            ),
          ),
        );
      },
    );
  }

  void showProductDetail(BuildContext context, String product) {
    final turkishProduct = getTurkishProductName(product);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF8F6EC),
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
                child: productImage(product, 190),
              ),
              const SizedBox(height: 18),
              Text(
                turkishProduct,
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
                style: const TextStyle(
                  color: Colors.black54,
                  height: 1.5,
                ),
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

    final turkishMaterial = getTurkishMaterialName(material);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F6EC),
        elevation: 0,
        foregroundColor: Colors.black87,
        title: const Text('HERCYCLE Koleksiyonu'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$turkishMaterial kumaştan\nneler üretebilirsin?',
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
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(22),
                            ),
                            child: productImage(product, 130),
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
                                        getTurkishProductName(product),
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