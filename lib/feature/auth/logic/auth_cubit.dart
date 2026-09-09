import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/auth_service.dart';
import 'auth_state.dart';
<<<<<<< Updated upstream

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
=======
class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit(this.authService) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      await authService.login(email, password);
      emit(AuthSuccess());
>>>>>>> Stashed changes
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

<<<<<<< Updated upstream
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
=======
  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      await authService.register(email, password);
      emit(AuthSuccess());
>>>>>>> Stashed changes
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    try {
<<<<<<< Updated upstream
      await _authService.resetPassword(email);
      emit(AuthSuccess("Password reset email sent!"));
=======
      await authService.sendPasswordReset(email);
      emit(AuthSuccess());
>>>>>>> Stashed changes
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}