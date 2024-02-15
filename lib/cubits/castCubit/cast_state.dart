
abstract class CastState {}

class CastInitial extends CastState{}
class CastLoading extends CastState{}
class CastSuccess extends CastState{
  final List cast;

  CastSuccess({required this.cast});
}
class CastFailed extends CastState{
  final String exp;

  CastFailed({required this.exp});
}