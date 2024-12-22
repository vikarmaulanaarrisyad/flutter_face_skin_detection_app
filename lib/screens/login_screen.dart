import 'package:face_skin_detection_app/screens/forgot_password_screen.dart';
import 'package:face_skin_detection_app/screens/home_screen.dart';
import 'package:face_skin_detection_app/screens/register_screen.dart';
import 'package:face_skin_detection_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService =
      AuthService('http://127.0.0.1:5000/api'); // Masukkan base URL di sini

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Validasi jika email atau password kosong
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan Password wajib diisi!')),
      );
      return; // Menghentikan eksekusi fungsi login jika ada input kosong
    }

    try {
      final result = await _authService.login(email, password);

      // Check if the widget is still mounted before using BuildContext
      if (mounted) {
        if (result['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Berhasil!')),
          );
          // Navigate to the home screen if login is successful
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          // Show the message from the response in case of failure
          String message = result['message'] ?? 'Login Gagal';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      }
    } catch (e) {
      // Check if the widget is still mounted before showing the error message
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen(),
                  ),
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
                        builder: (context) => RegisterScreen(),
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
