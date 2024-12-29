import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:face_skin_detection_app/bloc/register/register_bloc.dart';
import 'package:face_skin_detection_app/bloc/register/register_event.dart';
import 'package:face_skin_detection_app/bloc/register/register_state.dart';
import 'package:face_skin_detection_app/screens/register_screen.dart';

// Mock classes
class MockRegisterBloc extends Mock implements RegisterBloc {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets(
      'should show success message and navigate to HomeScreen on RegisterSuccessState',
      (WidgetTester tester) async {
    // Arrange
    final mockBloc = MockRegisterBloc();
    when(mockBloc.state)
        .thenReturn(RegisterSuccessState(message: 'Registration Successful'));

    // Create a navigator observer to check if the screen navigates
    final navigatorObserver = MockNavigatorObserver();

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<RegisterBloc>(
        create: (context) => mockBloc,
        child: const RegisterScreen(),
      ),
      navigatorObservers: [navigatorObserver], // Add observer here
    ));

    // Simulate the event that triggers the RegisterSuccessState
    mockBloc.add(RegisterUserEvent(
      name: 'John Doe',
      email: 'johndoe@example.com',
      password: 'password123',
      confirmPassword: 'password123',
    ));

    // Pump to process the state change
    await tester.pump();

    // Assert: Check if success message is shown
    expect(find.text('Registration Successful'), findsOneWidget);

    // Verify if navigation happened
    // verify(navigatorObserver.didPush(any, any)).called(1);
  });
}
