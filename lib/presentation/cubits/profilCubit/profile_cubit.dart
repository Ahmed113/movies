import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies/data/repo/image_repo.dart';
import 'package:movies/presentation/cubits/profilCubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(InitialProfileState());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  XFile? image;
  bool isSelected = false;
  String? photoUrl;

  Future<void> changePic(XFile imageFile)async{
    emit(ChangePicLoading());
    try{
      User? user = _auth.currentUser;
      if (user!=null) {
        String imgUrl = await uploadImageToStorage(imageFile);
        await user.updatePhotoURL(imgUrl);
        await user.reload();
        user = _auth.currentUser;
        isSelected = false;
        photoUrl = user!.photoURL!;
        emit(ChangePicSuccess(imgUrl: user!.photoURL!));
      }
    }on Exception catch(e){
      emit(ChangePicFailed(msg: "$e"));

    }
  }
  void handleImagePick(ImageSource source) async {
    XFile? image = await pickImage(source);
    if (image != null) {
      await changePic(image);
    }
  }

  // void _handleImagePick(ImageSource source) async {
  //    image = await pickImage(source);
  //   if (image != null) {
  //     await uploadImageToStorage(image!);
  //   }
  // }

  Future<XFile?> pickImage(ImageSource source) async {
    image = await pickImageRepo(source);
    isSelected = true;
    return image;
  }

  Future<String> uploadImageToStorage(XFile imageFile) async {
    return await uploadImageToStorageRepo(imageFile);
  }
}
