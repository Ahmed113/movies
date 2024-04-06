import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class SocialSignInState{}
class SocialSignInInitial extends SocialSignInState{}

class SignInWithEmailAndPasswordSuccess extends SocialSignInState{
  SignInWithEmailAndPasswordSuccess({required this.user});
  User user;
}
class SignInWithEmailAndPasswordLoading extends SocialSignInState{}
class ChangePasswordVisibilityState extends SocialSignInState{}
class SignInWithEmailAndPasswordFailed extends SocialSignInState{
  SignInWithEmailAndPasswordFailed({required this.msg});
  String msg;
}

class GoogleSignInSuccess extends SocialSignInState{
  GoogleSignInSuccess({required this.user});
  User user;
}
class GoogleSignInLoading extends SocialSignInState{}
class GoogleSignInFailed extends SocialSignInState{
  GoogleSignInFailed({required this.msg});
  String msg;
}

class FBSignInSuccess extends SocialSignInState{
  FBSignInSuccess({required this.user,});
  Map user;
}
class FBSignInLoading extends SocialSignInState{}
class FBSignInFailed extends SocialSignInState{
  FBSignInFailed({required this.msg});
  String msg;
}
