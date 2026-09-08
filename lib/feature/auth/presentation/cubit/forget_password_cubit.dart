import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {}

class ForgetPasswordError extends ForgetPasswordState {
  final String message;

  ForgetPasswordError(this.message);
}

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendPasswordResetEmail(String email) async {
    if (email.trim().isEmpty) {
      emit(ForgetPasswordError('Please enter your email address.'));
      return;
    }

    emit(ForgetPasswordLoading());

    try {
      await _auth.sendPasswordResetEmail(
        email: email.trim(),
      );

      emit(ForgetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'invalid-email':
          message = 'Please enter a valid email address.';
          break;

        case 'user-not-found':
          message = 'No account found with this email.';
          break;

        case 'too-many-requests':
          message = 'Too many requests. Please try again later.';
          break;

        case 'network-request-failed':
          message = 'Please check your internet connection.';
          break;

        default:
          message = e.message ?? 'Something went wrong. Please try again.';
      }

      emit(ForgetPasswordError(message));
    } catch (e) {
      emit(ForgetPasswordError(
        'Something went wrong. Please try again.',
      ));
    }
  }
}