import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {}

class UpdateProfileError extends UpdateProfileState {
  final String message;

  UpdateProfileError(this.message);
}

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateProfile({
    required String name,
  }) async {
    final User? user = _auth.currentUser;

    if (user == null) {
      emit(UpdateProfileError('No user is currently signed in.'));
      return;
    }

    if (name.trim().isEmpty) {
      emit(UpdateProfileError('Please enter your name.'));
      return;
    }

    emit(UpdateProfileLoading());

    try {
      await user.updateDisplayName(name.trim());
      await user.reload();

      emit(UpdateProfileSuccess());
    } on FirebaseAuthException catch (e) {
      emit(
        UpdateProfileError(
          e.message ?? 'Failed to update profile.',
        ),
      );
    } catch (e) {
      emit(
        UpdateProfileError(
          'Something went wrong. Please try again.',
        ),
      );
    }
  }

  Future<void> sendPasswordResetEmail() async {
    final User? user = _auth.currentUser;

    if (user == null || user.email == null) {
      emit(UpdateProfileError('No signed-in email found.'));
      return;
    }

    emit(UpdateProfileLoading());

    try {
      await _auth.sendPasswordResetEmail(
        email: user.email!,
      );

      emit(UpdateProfileSuccess());
    } on FirebaseAuthException catch (e) {
      emit(
        UpdateProfileError(
          e.message ?? 'Failed to send password reset email.',
        ),
      );
    } catch (e) {
      emit(
        UpdateProfileError(
          'Something went wrong. Please try again.',
        ),
      );
    }
  }
}