// register_state.dart
abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final String message;

  RegisterSuccessState({required this.message});
}

class RegisterFailureState extends RegisterState {
  final String errorMessage;

  RegisterFailureState({required this.errorMessage});
}
