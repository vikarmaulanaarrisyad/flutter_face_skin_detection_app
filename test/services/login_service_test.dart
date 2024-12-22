import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:face_skin_detection_app/services/auth_service.dart';
import 'package:face_skin_detection_app/screens/login_screen.dart';
import 'package:face_skin_detection_app/screens/home_screen.dart';

import 'auth_service_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
  });

  Future<void> pumpLoginScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(authService: mockAuthService),
      ),
    );
  }

  testWidgets('Navigates to home screen on successful login',
      (WidgetTester tester) async {
    await pumpLoginScreen(tester);

    // Masukkan email dan password valid
    await tester.enterText(find.byType(TextField).first, 'emi@gmail.com');
    await tester.enterText(find.byType(TextField).at(1), '1234');

    // Mock login sukses
    when(mockAuthService.login('emi@gmail.com', '1234'))
        .thenAnswer((_) async => {'success': true});

    // Tekan tombol login
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle(); // Tunggu animasi selesai

    // Periksa apakah navigasi berhasil ke HomeScreen
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
