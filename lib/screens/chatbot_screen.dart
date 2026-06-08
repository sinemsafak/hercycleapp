import 'package:flutter/material.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      ['Motivasyon', 'Güne pozitif başla', Icons.star],
      ['Üretim Planı', 'Üretimini planla', Icons.calendar_month],
      ['Stres Yönetimi', 'Rahatlatıcı destek al', Icons.spa],
      ['Sürdürülebilir İpuçları', 'Daha bilinçli üret', Icons.lightbulb],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hera AI'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Girişimci Asistanın',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            ...options.map(
              (item) => Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Icon(item[2] as IconData, color: const Color(0xFF2E7D32)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item[0] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item[1] as String,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Hera’ya bir şey sor...',
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xFF2E7D32),
                    child: Icon(Icons.send, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}