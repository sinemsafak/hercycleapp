import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

import '../widgets/app_button.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String selectedRole = 'Kadın Girişimci';
  bool isLoading = false;

  Future<void> registerUser() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      showMessage('Eksik bilgi', 'Lütfen tüm alanları doldur.');
      return;
    }

    if (passwordController.text.trim().length < 6) {
      showMessage('Şifre kısa', 'Şifre en az 6 karakter olmalı.');
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final uid = userCredential.user!.uid;

      final database = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL:
            'https://hercycle-ai-default-rtdb.europe-west1.firebasedatabase.app',
      );

      await database.ref().child('users').child(uid).set({
        'uid': uid,
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'role': selectedRole,
        'createdAt': DateTime.now().toIso8601String(),
      }).timeout(
        const Duration(seconds: 10),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Kayıt sırasında bir hata oluştu.';

      if (e.code == 'email-already-in-use') {
        message = 'Bu e-posta adresi zaten kayıtlı.';
      } else if (e.code == 'invalid-email') {
        message = 'Geçerli bir e-posta adresi gir.';
      } else if (e.code == 'weak-password') {
        message = 'Şifre çok zayıf. Daha güçlü bir şifre dene.';
      }

      showMessage('Kayıt başarısız', message);
    } catch (e) {
      showMessage(
        'Hata',
        e.toString(),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void showMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6EC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/hercycle_logo.png',
                  width: 120,
                ),
                const SizedBox(height: 18),
                const Text(
                  'Hesap Oluştur',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF143D22),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'HERCYCLE AI deneyimine başlamak için bilgilerini gir.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 28),
                _InputField(
                  controller: nameController,
                  label: 'Ad Soyad',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 14),
                _InputField(
                  controller: emailController,
                  label: 'E-posta',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 14),
                _InputField(
                  controller: passwordController,
                  label: 'Şifre',
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedRole,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(
                          value: 'Kadın Girişimci',
                          child: Text('Kadın Girişimci'),
                        ),
                        DropdownMenuItem(
                          value: 'Normal Kullanıcı',
                          child: Text('Normal Kullanıcı'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          selectedRole = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                isLoading
                    ? const CircularProgressIndicator(
                        color: Color(0xFF2E7D32),
                      )
                    : AppButton(
                        text: 'Kayıt Ol',
                        onPressed: registerUser,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;

  const _InputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF2E7D32),
        ),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}