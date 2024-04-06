import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'sign_in-state.dart';

class SocialSignInCubit extends Cubit<SocialSignInState>{
  SocialSignInCubit():super(SocialSignInInitial());

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email',"https://www.googleapis.com/auth/userinfo.profile"]);
  late FirebaseAuth _auth;
  bool isUserSignedIn = false;
  User? user;
  Map? userData;
  bool userSignedIn = false;
  bool obsecurePass = true;

  Future<void> emailPasswordSignIn({required String email, required String password}) async{
    _auth = FirebaseAuth.instance;
    emit(SignInWithEmailAndPasswordLoading());
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      emit(SignInWithEmailAndPasswordSuccess(user: userCredential.user!));
    }on Exception catch(e){
      emit(SignInWithEmailAndPasswordFailed(msg: "User isn't exist "));
    }
  }

  void changePasswordVisibility({bool? obSecure}) async {
    obsecurePass = !obsecurePass;
    emit(ChangePasswordVisibilityState());
  }

  Future<void> logInWithGoogle()async{
    emit(GoogleSignInLoading());
   try{
     FirebaseApp defaultApp = await Firebase.initializeApp();
     _auth = FirebaseAuth.instanceFor(app: defaultApp);
     userSignedIn = await _googleSignIn.isSignedIn();
     isUserSignedIn = userSignedIn;
     if (isUserSignedIn) {
       user = _auth.currentUser;
       emit(GoogleSignInSuccess(user: user!));
     }else{
       final GoogleSignInAccount? googleUser =
       await _googleSignIn.signIn();
       final GoogleSignInAuthentication? googleAuth =
       await googleUser?.authentication;
       final AuthCredential credential =
       GoogleAuthProvider.credential(
           accessToken: googleAuth?.accessToken,
           idToken: googleAuth?.idToken
       );
       user = (await _auth.signInWithCredential(credential)).user;
       userSignedIn = await _googleSignIn.isSignedIn();
       isUserSignedIn = userSignedIn;
       if (isUserSignedIn) {
         emit(GoogleSignInSuccess(user: user!));
       }
     }
   } on Exception catch(exp){
     emit(GoogleSignInFailed(msg: exp.toString()));
   }
  }

  Future<void> googleSignOut() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
    emit(GoogleSignInFailed(msg: "Signed Out"));
  }

  // late final String userAccessToken;
  Future<void> loginWithFB()async {
    emit(FBSignInLoading());
    try{
      final LoginResult result = await FacebookAuth.instance.login(
          permissions: ["public_profile","email"]);
      //     .then((value) {
      //   FacebookAuth.instance.getUserData().then((userData)async{
      //     emit(FBLoginSuccess(user: userData));
      //   });
      // });
      if (result.status == LoginStatus.success) {
        // final AccessToken userAccessToken = result.accessToken!;
        userData = await FacebookAuth.instance.getUserData();
        emit(FBSignInSuccess(user: userData!,));
      } else {
        emit(FBSignInFailed(msg: "Facebook login failed"));
      }

    }on Exception catch(msg){
      emit(FBSignInFailed(msg: "$msg"));
    }
  }

  Future<void> fbSignOut() async{
    emit(FBSignInFailed(msg: "Signed Out"));
    FacebookAuth.instance.logOut();
  }
}