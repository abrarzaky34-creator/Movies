import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(AuthInitial());

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await _authService.registerWithEmail(
        email: email,
        password: password,
      );
      emit(AuthSuccess("Account created successfully!"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await _authService.loginWithEmail(
        email: email,
        password: password,
      );
      emit(AuthSuccess("Logged in successfully!"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    try {
      await _authService.resetPassword(email);
      emit(AuthSuccess("Password reset email sent!"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}