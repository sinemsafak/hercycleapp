import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

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

  bool isRegisterMode = false;
  bool isLoading = false;
  bool hidePassword = true;
  bool isEntrepreneur = true;

  final Color darkGreen = const Color(0xFF143D22);
  final Color mainGreen = const Color(0xFF2E7D32);
  final Color cream = const Color(0xFFF8F6EC);

  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMessage('Eksik bilgi', 'E-posta ve şifre alanlarını doldur.');
      return;
    }

    try {
      setState(() => isLoading = true);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Giriş sırasında bir hata oluştu.';

      if (e.code == 'user-not-found') {
        message = 'Bu e-posta ile kayıtlı bir hesap bulunamadı.';
      } else if (e.code == 'wrong-password') {
        message = 'Şifre hatalı.';
      } else if (e.code == 'invalid-email') {
        message = 'Geçerli bir e-posta adresi gir.';
      } else if (e.code == 'invalid-credential') {
        message = 'E-posta veya şifre hatalı.';
      }

      showMessage('Giriş başarısız', message);
    } catch (e) {
      showMessage('Hata', e.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> registerUser() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      showMessage('Eksik bilgi', 'Lütfen tüm alanları doldur.');
      return;
    }

    if (password.length < 6) {
      showMessage('Şifre kısa', 'Şifre en az 6 karakter olmalı.');
      return;
    }

    try {
      setState(() => isLoading = true);

      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      final database = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL:
            'https://hercycle-ai-default-rtdb.europe-west1.firebasedatabase.app',
      );

      await database.ref().child('users').child(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'role': isEntrepreneur ? 'entrepreneur' : 'member',
        'roleLabel': isEntrepreneur ? 'Girişimci' : 'Üye',
        'createdAt': DateTime.now().toIso8601String(),
      }).timeout(const Duration(seconds: 10));

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
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
      showMessage('Hata', e.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void showMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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

  void toggleMode() {
    setState(() {
      isRegisterMode = !isRegisterMode;
      isLoading = false;
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      hidePassword = true;
      isEntrepreneur = true;
    });
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
      backgroundColor: cream,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                _LogoCard(),
                const SizedBox(height: 26),

                Text(
                  isRegisterMode ? 'HERCYCLE’a katıl' : 'HERCYCLE',
                  style: TextStyle(
                    fontSize: isRegisterMode ? 30 : 34,
                    fontWeight: FontWeight.w900,
                    color: darkGreen,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  isRegisterMode
                      ? 'Üretimini, fikrini ve yolculuğunu HERCYCLE ile büyüt.'
                      : 'Hesabına giriş yap ve kaldığın yerden devam et.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 32),

                if (isRegisterMode) ...[
                  _InputField(
                    controller: nameController,
                    label: 'Ad Soyad',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 14),
                ],

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
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() => hidePassword = !hidePassword);
                    },
                    icon: Icon(
                      hidePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.black45,
                    ),
                  ),
                ),

                if (isRegisterMode) ...[
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.eco_outlined,
                          color: mainGreen,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Girişimci misin?',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Switch(
                          value: isEntrepreneur,
                          activeColor: mainGreen,
                          onChanged: (value) {
                            setState(() => isEntrepreneur = value);
                          },
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : isRegisterMode
                            ? registerUser
                            : loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGreen,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: mainGreen.withOpacity(0.45),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            isRegisterMode ? 'Kayıt Ol' : 'Giriş Yap',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isRegisterMode
                          ? 'Zaten hesabın var mı?'
                          : 'Hesabın yok mu?',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: isLoading ? null : toggleMode,
                      child: Text(
                        isRegisterMode ? 'Giriş yap' : 'Kayıt ol',
                        style: TextStyle(
                          color: darkGreen,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.82),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/hercycle_logo.png',
          width: 78,
          height: 78,
          fit: BoxFit.cover,
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
  final Widget? suffixIcon;

  const _InputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
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
        suffixIcon: suffixIcon,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black45),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}