import 'package:face_skin_detection_app/bloc/register/register_bloc.dart';
import 'package:face_skin_detection_app/bloc/register/register_event.dart';
import 'package:face_skin_detection_app/bloc/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_skin_detection_app/services/auth_service.dart';
import 'package:face_skin_detection_app/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
// Define TextEditingController for each input field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterBloc(AuthService('http://127.0.0.1:5000/api')),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
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

              return Column(
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
                      // Fetch values from controllers
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
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                              builder: (context) => const LoginScreen(),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
