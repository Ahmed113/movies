import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  EmailVerificationCubit() : super(InitialEmailVerificationState());
  bool isEmailVerified = false;
  Timer? timer;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendEmail() async {
    try {
      _auth.currentUser?.sendEmailVerification();
      _storeVerificationStatus('pending');
      timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
        await _auth.currentUser?.reload();
        isEmailVerified = _auth.currentUser!.emailVerified;
        if (isEmailVerified) {
          _storeVerificationStatus("Verified");
          // _auth.currentUser?.linkWithCredential(credential);
          emit(SuccessEmailVerificationState(isVerified: isEmailVerified));
          timer.cancel();
        }
      });

      // emit(InitialEmailVerificationState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle case where user email doesn't exist
        emit(FailedEmailVerificationState(msg: "User email doesn't exist"));
      } else {
        // Handle other Firebase Authentication exceptions
        emit(FailedEmailVerificationState(
            msg: e.message ?? "An error occurred"));
      }
    } on Exception catch (e) {
      _auth.currentUser?.delete();
      emit(FailedEmailVerificationState(msg: "$e"));
    }
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
  }

  Future<void> checkAndDeleteUserOnStart() async {
    final prefs = await SharedPreferences.getInstance();
    final status = prefs.getString('verification_status');
    if (status == 'pending') {
      await _auth.currentUser?.delete();
      emit(FailedEmailVerificationState(msg: "Email verification timed out"));
    }
  }

  Future<void> _storeVerificationStatus(String status) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('verification_status', status);
  }

  void dispose() {
    timer?.cancel();
  }
}
