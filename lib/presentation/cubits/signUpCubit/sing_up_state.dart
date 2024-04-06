abstract class SignUpState{}
class SignUpStateInitial extends SignUpState{}
class ChangePasswordVisibilityState extends SignUpState{}
class ChangeConfirmPasswordVisibilityState extends SignUpState{}
class SubmitLoading extends SignUpState{
  SubmitLoading({required this.isLoading});
  bool isLoading;
}
class SubmitSuccess extends SignUpState{}
class SubmitFailed extends SignUpState{
  SubmitFailed({required String this.msg});
  String msg;
}

