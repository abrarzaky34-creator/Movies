abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

<<<<<<< Updated upstream
class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess(this.message);
}

class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
=======
class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
>>>>>>> Stashed changes
}