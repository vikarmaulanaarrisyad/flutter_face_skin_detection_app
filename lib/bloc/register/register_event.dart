// register_event.dart
abstract class RegisterEvent {}

class RegisterUserEvent extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterUserEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
