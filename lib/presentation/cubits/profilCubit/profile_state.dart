abstract class ProfileState{}
class InitialProfileState extends ProfileState{}
class ChangePicLoading extends ProfileState{}
class ChangePicSuccess extends ProfileState{
  ChangePicSuccess({required this.imgUrl});
  String imgUrl;
}
class ChangePicFailed extends ProfileState{
  ChangePicFailed({required this.msg});
  String msg;
}
// class InitialProfileState extends ProfileState{}