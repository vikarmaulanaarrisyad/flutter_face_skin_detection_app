import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:face_skin_detection_app/services/auth_service.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService _authService;

  RegisterBloc(this._authService) : super(RegisterInitialState()) {
    on<RegisterUserEvent>(_onRegisterUserEvent);
  }

  Future<void> _onRegisterUserEvent(
      RegisterUserEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());

    if (event.password != event.confirmPassword) {
      emit(RegisterFailureState(
          errorMessage: "Password dan konfirmasi password tidak cocok"));
      return;
    }

    try {
      final result =
          await _authService.register(event.name, event.email, event.password);

      if (result['success']) {
        emit(RegisterSuccessState(message: 'Registrasi Berhasil!'));
      } else {
        emit(RegisterFailureState(
            errorMessage: result['message'] ?? 'Registrasi Gagal'));
      }
    } catch (e) {
      emit(RegisterFailureState(errorMessage: 'Terjadi kesalahan: $e'));
    }
  }
}
