import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies/presentation/cubits/signUpCubit/sing_up_state.dart';

import '../../../data/repo/image_repo.dart';


class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpStateInitial());
  bool obsecureConfirmPass = true;
  bool obsecurePass = true;
  bool isLoading = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  XFile? image;

  void changePasswordVisibility({bool? obSecure}) async {
    obsecurePass = !obsecurePass;
    emit(ChangePasswordVisibilityState());
  }

  void changeConfirmPasswordVisibility({bool? obSecure}) async {
    obsecureConfirmPass = !obsecureConfirmPass;
    emit(ChangeConfirmPasswordVisibilityState());
  }

  Future<void> submitForm(
      {required String email,
      required String password,
      required String name,
      XFile? imageFile}) async {
    emit(SubmitLoading(isLoading: isLoading));
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        if (imageFile != null) {
          String imgUrl = await uploadImageToStorage(imageFile);
          await user.updatePhotoURL(imgUrl);
        }
        await user.reload();
        user = _auth.currentUser;
        emit(SubmitSuccess());
      }

      // await _fireStore.collection("users").doc(userCredential.user!.uid).set({
      //   'email': email,
      //   'username': name
      // });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(SubmitFailed(msg: "Email already exists"));
      } else if (e.code == 'weak-password') {
        emit(SubmitFailed(msg: 'The password is too weak'));
      } else if (e.code == 'user-not-found') {
        // Handle case where user email doesn't exist
        emit(SubmitFailed(msg: "User email doesn't exist"));
      }
    }
  }

  Future<XFile?> pickImage(ImageSource source) async {
    image = await pickImageRepo(source);
    return image;
  }

  Future<String> uploadImageToStorage(XFile imageFile) async {
    return await uploadImageToStorageRepo(imageFile);
  }

  dispose(){
    image = null;
  }
}
