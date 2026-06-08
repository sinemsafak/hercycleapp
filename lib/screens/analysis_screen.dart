import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'result_screen.dart';

class AnalysisScreen extends StatefulWidget {
  final File imageFile;

  const AnalysisScreen({
    super.key,
    required this.imageFile,
  });

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  int step = 0;
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
      setState(() => step = 0);
      await Future.delayed(const Duration(seconds: 1));

      setState(() => step = 1);
      await Future.delayed(const Duration(seconds: 1));

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(apiUrl),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          widget.imageFile.path,
        ),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode != 200) {
        throw Exception('API hatası: $responseBody');
      }

      final data = jsonDecode(responseBody);

      setState(() => step = 2);
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            material: data['material'] ?? 'Bilinmiyor',
            confidence: (data['confidence'] ?? 0).toDouble(),
            trendScore: data['trend_score'] ?? 0,
            recommendedProducts:
                List<String>.from(data['recommended_products'] ?? []),
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
            child: Text(
              'Analiz sırasında hata oluştu:\n$errorMessage',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final screens = [
      _analysisA(),
      _analysisB(),
      _analysisC(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('AI Analizi')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: screens[step],
      ),
    );
  }

  Widget _analysisA() {
    return const Padding(
      key: ValueKey('a'),
      padding: EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI kumaşı analiz ediyor...',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          _CheckLine(text: 'Görsel alınıyor'),
          _CheckLine(text: 'Materyal algılanıyor'),
          _CheckLine(text: 'Renk ve doku inceleniyor'),
          _CheckLine(text: 'Trend skoru hazırlanıyor'),
          Spacer(),
          LinearProgressIndicator(),
        ],
      ),
    );
  }

  Widget _analysisB() {
    return const Center(
      key: ValueKey('b'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: CircularProgressIndicator(
              strokeWidth: 12,
              value: 0.72,
              color: Color(0xFF2E7D32),
            ),
          ),
          SizedBox(height: 24),
          Text(
            '%72',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text('Model sonucu bekleniyor...'),
        ],
      ),
    );
  }

  Widget _analysisC() {
    return const Padding(
      key: ValueKey('c'),
      padding: EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Son kontroller yapılıyor',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          _DoneLine(text: 'Görsel alındı'),
          _DoneLine(text: 'Kumaş türü bulundu'),
          _DoneLine(text: 'Ürün önerileri hazırlanıyor'),
          Spacer(),
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

class _CheckLine extends StatelessWidget {
  final String text;

  const _CheckLine({required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.hourglass_empty, color: Color(0xFF2E7D32)),
      title: Text(text),
    );
  }
}

class _DoneLine extends StatelessWidget {
  final String text;

  const _DoneLine({required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.check_circle, color: Color(0xFF2E7D32)),
      title: Text(text),
    );
  }
}