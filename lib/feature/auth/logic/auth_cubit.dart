import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/feature/auth/data/auth_service.dart';
import 'package:movies/feature/auth/logic/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit(this.authService) : super(AuthInitialState());

  // تسجيل الدخول
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());
    try {
      final credential = await authService.login(email: email, password: password);
      if (credential.user != null) {
        emit(AuthSuccessState(credential.user!));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  // إنشاء حساب
  Future<void> register({required String email, required String password}) async {
    emit(AuthLoadingState());
    try {
      final credential = await authService.register(email: email, password: password);
      if (credential.user != null) {
        emit(AuthSuccessState(credential.user!));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  // استعادة كلمة السر
  Future<void> resetPassword({required String email}) async {
    emit(AuthLoadingState());
    try {
      await authService.resetPassword(email: email);
      emit(PasswordResetSentState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}