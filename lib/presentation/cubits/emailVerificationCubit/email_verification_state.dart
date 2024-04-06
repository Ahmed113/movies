abstract class EmailVerificationState{}
class InitialEmailVerificationState extends EmailVerificationState{}
class SuccessEmailVerificationState extends EmailVerificationState{
  SuccessEmailVerificationState({this.isVerified});
  bool? isVerified;
}
class FailedEmailVerificationState extends EmailVerificationState{
  FailedEmailVerificationState({this.msg});
  String? msg;
}