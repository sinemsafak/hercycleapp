import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'result_screen.dart';

class AnalysisScreen extends StatefulWidget {
  final File imageFile;

  const AnalysisScreen({super.key, required this.imageFile});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  int step = 0;
  bool hasError = false;
  String errorMessage = '';
  String detectedMaterial = '';

  final String apiUrl = 'http://10.0.2.2:8000/predict';

  @override
  void initState() {
    super.initState();
    startAnalysis();
  }

  Future<void> startAnalysis() async {
    try {
      setState(() {
        step = 0;
        hasError = false;
      });

      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      request.files.add(
        await http.MultipartFile.fromPath('file', widget.imageFile.path),
      );

      setState(() => step = 1);

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode != 200) {
        throw Exception('API hatası: $responseBody');
      }

      final data = jsonDecode(responseBody);

      setState(() {
        detectedMaterial = data['material'] ?? 'Bilinmiyor';
        step = 2;
      });

      await Future.delayed(const Duration(milliseconds: 1200));

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            imageFile: widget.imageFile,
            material: data['material'] ?? 'Bilinmiyor',
            confidence: (data['confidence'] ?? 0).toDouble(),
            trendScore: data['trend_score'] ?? 0,
            recommendedProducts: List<String>.from(
              data['recommended_products'] ?? [],
            ),
          ),
        ),
      );
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('AI Analizi')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 54,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Analiz tamamlanamadı',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 22),
                  ElevatedButton(
                    onPressed: startAnalysis,
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final pages = [_uploadingView(), _detectingView(), _completedView()];

    return Scaffold(
      appBar: AppBar(title: const Text('AI Analizi')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 450),
        child: pages[step],
      ),
    );
  }

  Widget _uploadingView() {
    return Center(
      key: const ValueKey('uploading'),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Image.file(
                widget.imageFile,
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: Color(0xFF2E7D32)),
            const SizedBox(height: 22),
            const Text(
              'Fotoğraf hazırlanıyor...',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF143D22),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Kumaş görseli yapay zekâ modeline gönderiliyor.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detectingView() {
    return Center(
      key: const ValueKey('detecting'),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 120,
              height: 120,
              child: CircularProgressIndicator(
                strokeWidth: 10,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Materyal algılanıyor...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF143D22),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Model kumaş dokusunu ve görsel özellikleri inceliyor.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _completedView() {
    return Center(
      key: const ValueKey('completed'),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 42,
              backgroundColor: Color(0xFFE2EEDB),
              child: Icon(
                Icons.check_rounded,
                size: 54,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '$detectedMaterial algılandı',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF143D22),
              ),
            ),
            const SizedBox(height: 14),
            const _DoneLine(text: 'Kumaş türü bulundu'),
            const _DoneLine(text: 'Trend skoru hazırlandı'),
            const _DoneLine(text: 'Ürün önerileri oluşturuldu'),
          ],
        ),
      ),
    );
  }
}

class _DoneLine extends StatelessWidget {
  final String text;

  const _DoneLine({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 22),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
