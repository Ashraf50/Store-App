import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  signIn({required String email, required String password}) async {
    emit(SignInLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SignInFailure(MassageError: "user-not-found"));
      } else if (e.code == 'wrong-password') {
        emit(SignInFailure(MassageError: "wrong-password"));
      } else {
        emit(SignInFailure(MassageError: e.code));
      }
    } on Exception {
      emit(SignInFailure(MassageError: "Something went wrong"));
    }
  }

  SignUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      CollectionReference users =
          FirebaseFirestore.instance.collection("Users");
      users
          .doc(user.user!.uid)
          .set(
            {
              'username': userName,
              'email': email,
              'password': password,
            },
          )
          .then(
            (value) => print("User Added"),
          )
          .catchError((error) => print("Failed to add user: $error"));
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFailure(MassageError: "The password provided is to weak"));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpFailure(MassageError: "email-already-in-use"));
      } else {
        emit(SignUpFailure(MassageError: e.code));
      }
    } on Exception {
      emit(SignUpFailure(MassageError: "Something Went Wrong"));
    }
  }

  ResetPassword({required String email}) async {
    emit(ResetPasswordLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ResetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(ResetPasswordFailure(massageError: e.code));
    } on Exception {
      emit(ResetPasswordFailure(massageError: "Something Went Wrong"));
    }
  }
}
