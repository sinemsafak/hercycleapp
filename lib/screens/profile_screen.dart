import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color cream = const Color(0xFFF8F6EC);
  final Color darkGreen = const Color(0xFF143D22);
  final Color mainGreen = const Color(0xFF2E7D32);
  final Color softGreen = const Color(0xFFEFF8D8);

  final user = FirebaseAuth.instance.currentUser;

  bool isUploading = false;

  late final FirebaseDatabase database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        'https://hercycle-ai-default-rtdb.europe-west1.firebasedatabase.app',
  );

  Future<void> pickProfileImage() async {
    if (user == null) return;

    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 45,
      maxWidth: 600,
    );

    if (pickedImage == null) return;

    setState(() => isUploading = true);

    final bytes = await File(pickedImage.path).readAsBytes();
    final base64Image = base64Encode(bytes);

    await database.ref().child('users').child(user!.uid).update({
      'profileImageBase64': base64Image,
    });

    setState(() => isUploading = false);
  }

  Future<void> sendPasswordResetEmail() async {
    if (user?.email == null) return;

    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: user!.email!,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Şifre değiştirme bağlantısı e-posta adresine gönderildi.'),
      ),
    );
  }

  ImageProvider? getProfileImage(Map<dynamic, dynamic>? data) {
    final imageBase64 = data?['profileImageBase64'];

    if (imageBase64 == null || imageBase64.toString().isEmpty) {
      return null;
    }

    try {
      final bytes = base64Decode(imageBase64);
      return MemoryImage(bytes);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        backgroundColor: cream,
        body: const Center(
          child: Text('Kullanıcı bulunamadı.'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: const Text('Profilim'),
        backgroundColor: cream,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: database.ref().child('users').child(user!.uid).onValue,
        builder: (context, snapshot) {
          final rawData = snapshot.data?.snapshot.value;
          final data = rawData is Map ? rawData : null;

          final name = data?['name']?.toString() ?? 'HERCYCLE Kullanıcısı';
          final email = data?['email']?.toString() ?? user!.email ?? '';
          final roleLabel = data?['roleLabel']?.toString() ?? 'Üye';
          final profileImage = getProfileImage(data);

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 16, 22, 24),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(22, 28, 22, 26),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.94),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: const Color(0xFFE5DECD)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: pickProfileImage,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 62,
                              backgroundColor: softGreen,
                              backgroundImage: profileImage,
                              child: profileImage == null
                                  ? Icon(
                                      Icons.person_rounded,
                                      size: 64,
                                      color: mainGreen,
                                    )
                                  : null,
                            ),
                            Positioned(
                              right: 2,
                              bottom: 4,
                              child: Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: mainGreen,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                                child: isUploading
                                    ? const Padding(
                                        padding: EdgeInsets.all(9),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.camera_alt_rounded,
                                        size: 19,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: darkGreen,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        email,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: softGreen,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          roleLabel,
                          style: TextStyle(
                            color: darkGreen,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                _ProfileActionCard(
                  icon: Icons.photo_camera_rounded,
                  title: 'Profil Fotoğrafı',
                  subtitle: 'Galeriden yeni profil fotoğrafı seç.',
                  onTap: pickProfileImage,
                ),

                const SizedBox(height: 14),

                _ProfileActionCard(
                  icon: Icons.lock_reset_rounded,
                  title: 'Şifreyi Değiştir',
                  subtitle: 'E-posta adresine şifre yenileme bağlantısı gönder.',
                  onTap: sendPasswordResetEmail,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfileActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.94),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFE5DECD)),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xFFEFF8D8),
                child: Icon(
                  Icons.eco_rounded,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF143D22),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12.5,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.black38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}