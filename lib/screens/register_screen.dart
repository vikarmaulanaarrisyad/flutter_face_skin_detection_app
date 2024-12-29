import 'package:face_skin_detection_app/bloc/register/register_bloc.dart';
import 'package:face_skin_detection_app/bloc/register/register_event.dart';
import 'package:face_skin_detection_app/bloc/register/register_state.dart';
import 'package:face_skin_detection_app/screens/home_screen.dart';
import 'package:face_skin_detection_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_skin_detection_app/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterBloc(AuthService('http://127.0.0.1:5000/api')),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(
              MediaQuery.of(context).size.width * 0.05), // Responsif padding
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              } else if (state is RegisterFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            builder: (context, state) {
              if (state is RegisterLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                // Membuat konten scrollable
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/logo_cepsten.png',
                        height: MediaQuery.of(context).size.height *
                            0.3, // Responsif tinggi logo
                        width: MediaQuery.of(context).size.width *
                            0.6, // Responsif lebar logo
                      ),
                    ),
                    const SizedBox(height: 5.0),

                    // Name Input
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Masukkan Nama Lengkap',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Email Input
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
                    const SizedBox(height: 16.0),

                    // Confirm Password Input
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Konfirmasi Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // Register Button
                    ElevatedButton(
                      onPressed: () {
                        final name = _nameController.text.trim();
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();
                        final confirmPassword =
                            _confirmPasswordController.text.trim();

                        // Validate fields
                        if (name.isEmpty ||
                            email.isEmpty ||
                            password.isEmpty ||
                            confirmPassword.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Semua field wajib diisi!')),
                          );
                          return;
                        }

                        if (password != confirmPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Password dan Konfirmasi Password tidak cocok!')),
                          );
                          return;
                        }

                        // Trigger the registration event
                        context.read<RegisterBloc>().add(
                              RegisterUserEvent(
                                name: name,
                                email: email,
                                password: password,
                                confirmPassword: confirmPassword,
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height *
                                0.02), // Responsif padding vertikal
                      ),
                      child: const Text(
                        'Daftar',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Text sudah punya akun
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sudah Punya Akun? ",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                  authService:
                                      AuthService('http://127.0.0.1:5000/api'),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Masuk Sekarang",
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
              );
            },
          ),
        ),
      ),
    );
  }
}
