import 'package:face_skin_detection_app/screens/login_screen.dart';
import 'package:face_skin_detection_app/services/auth_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Buat instance AuthService
  final AuthService _authService = AuthService('http://127.0.0.1:5000/api');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Skin Color App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(
          authService: _authService,
        ));
  }
}
