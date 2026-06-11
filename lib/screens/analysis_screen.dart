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
  bool hasError = false;
  String errorMessage = '';

  final String apiUrl = 'http://10.0.2.2:8000/predict';

  @override
  void initState() {
    super.initState();
    startAnalysis();
  }

  Future<void> startAnalysis() async {
    try {
      setState(() {
        hasError = false;
        errorMessage = '';
      });

      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      request.files.add(
        await http.MultipartFile.fromPath('file', widget.imageFile.path),
      );

      final response = await request.send().timeout(
            const Duration(seconds: 20),
          );

      final responseBody = await response.stream.bytesToString();

      if (response.statusCode != 200) {
        throw Exception('API hatası: $responseBody');
      }

      final data = jsonDecode(responseBody);

      await Future.delayed(const Duration(milliseconds: 900));

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
        backgroundColor: const Color(0xFFF8F6EC),
        appBar: AppBar(title: const Text('AI Analizi')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
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
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
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

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6EC),
      appBar: AppBar(
        title: const Text('AI Analizi'),
        backgroundColor: const Color(0xFFF8F6EC),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: const Color(0xFFE4E7DC)),
            ),
            child: Column(
              children: [
                const Text(
                  'AI kumaşı analiz ediyor...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    height: 1.2,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF143D22),
                  ),
                ),
                const SizedBox(height: 34),

                const _AnalysisLine(
                  emoji: '🧵',
                  text: 'Materyal algılanıyor',
                ),
                const _AnalysisLine(
                  emoji: '🎨',
                  text: 'Renk çıkarılıyor',
                ),
                const _AnalysisLine(
                  emoji: '🔍',
                  text: 'Desen analiz ediliyor',
                ),
                const _AnalysisLine(
                  emoji: '📈',
                  text: 'Trend skoru hesaplanıyor',
                ),
                const _AnalysisLine(
                  emoji: '✨',
                  text: 'Uygun ürünler hazırlanıyor',
                ),

                const Spacer(),

                Image.asset(
                  'assets/images/analysis_screen.png',
                  height: 190,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 22),

                const LinearProgressIndicator(
                  minHeight: 10,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xFF2E7D32),
                  backgroundColor: Color(0xFFE7EDE2),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Lütfen bekleyin...',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF6A756C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnalysisLine extends StatelessWidget {
  final String emoji;
  final String text;

  const _AnalysisLine({
    required this.emoji,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF143D22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}