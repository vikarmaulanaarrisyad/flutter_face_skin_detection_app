import 'package:face_skin_detection_app/screens/home_screen.dart';
import 'package:face_skin_detection_app/screens/register_screen.dart';
import 'package:face_skin_detection_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:face_skin_detection_app/utils/validators.dart';

class LoginScreen extends StatefulWidget {
  final AuthService authService; // Menambahkan parameter authService
  const LoginScreen({super.key, required this.authService});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // ignore: unused_field
  final AuthService _authService =
      AuthService('http://127.0.0.1:5000/api'); // Masukkan base URL di sini

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Validasi input kosong
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan Password wajib diisi!')),
      );
      return;
    }

    // Validasi format email
    if (!Validators.isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan email yang valid!')),
      );
      return;
    }

    try {
      final result = await widget.authService.login(email, password);

      if (mounted) {
        if (result['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Berhasil!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          final message = result['message'] ?? 'Login Gagal';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo
            Center(
              child: Image.asset(
                'assets/images/logo_cepsten.png',
                height: 250,
                width: 250,
              ),
            ),
            const SizedBox(height: 5.0),

            // Username Input
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Masukkan Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Password Input
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Masukkan Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),

            // Text Lupa Password
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text(
                "Lupa Password",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 15.0),

            // Login Button
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20.0),

            // Text belum punya akun
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Belum Punya Akun? ",
                  style: TextStyle(fontSize: 16.0),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Daftar Sekarang",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
