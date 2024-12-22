import 'package:bloc/bloc.dart';
import 'package:face_skin_detection_app/bloc/login/login_event.dart';
import 'package:face_skin_detection_app/bloc/login/login_state.dart';
import 'package:face_skin_detection_app/services/auth_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc(this.authService) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final result = await authService.login(event.email, event.password);

        // Ensure the 'success' key exists and is of type bool
        if (result['success'] == true) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure("Email atau password salah"));
        }
      } catch (e) {
        emit(LoginFailure("Terjadi kesalahan. Coba lagi."));
      }
    });
  }
}
