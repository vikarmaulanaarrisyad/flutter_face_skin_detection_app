import 'package:face_skin_detection_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_skin_detection_app/services/auth_service.dart';
import 'package:face_skin_detection_app/screens/home_screen.dart';
import 'package:face_skin_detection_app/bloc/register/register_bloc.dart';

import 'auth_service_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  late MockAuthService mockAuthService;
  late RegisterBloc registerBloc;

  setUp(() {
    mockAuthService = MockAuthService();
    registerBloc = RegisterBloc(mockAuthService);
  });

  Future<void> pumpRegisterScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RegisterBloc>(
          create: (context) => registerBloc,
          child: const RegisterScreen(),
        ),
      ),
    );
  }

  testWidgets('Navigates to home screen on successful registration',
      (WidgetTester tester) async {
    await pumpRegisterScreen(tester);

    // Masukkan data pendaftaran yang valid
    await tester.enterText(find.byType(TextField).first, 'John Doe');
    await tester.enterText(find.byType(TextField).at(1), 'john@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'password123');
    await tester.enterText(find.byType(TextField).at(3), 'password123');

    // Mock register sukses
    when(mockAuthService.register(
            'John Doe', 'john@example.com', 'password123'))
        .thenAnswer(
            (_) async => {'success': true, 'message': 'Registrasi sukses'});

    // Tekan tombol Daftar
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle(); // Tunggu animasi selesai

    // Periksa apakah navigasi berhasil ke HomeScreen
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Shows error message on failed registration',
      (WidgetTester tester) async {
    await pumpRegisterScreen(tester);

    // Masukkan data pendaftaran yang valid
    await tester.enterText(find.byType(TextField).first, 'Jane Doe');
    await tester.enterText(find.byType(TextField).at(1), 'jane@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'password123');
    await tester.enterText(find.byType(TextField).at(3), 'password123');

    // Mock register gagal
    when(mockAuthService.register(
            'Jane Doe', 'jane@example.com', 'password123'))
        .thenAnswer((_) async =>
            {'success': false, 'message': 'Email sudah terdaftar'});

    // Tekan tombol Daftar
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle(); // Tunggu animasi selesai

    // Periksa apakah pesan error muncul
    expect(find.text('Email sudah terdaftar'), findsOneWidget);
  });

  testWidgets('Shows error message when fields are empty',
      (WidgetTester tester) async {
    await pumpRegisterScreen(tester);

    // Tekan tombol Daftar tanpa mengisi data
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle(); // Tunggu animasi selesai

    // Periksa apakah pesan error muncul
    expect(find.text('Semua field wajib diisi!'), findsOneWidget);
  });
}
