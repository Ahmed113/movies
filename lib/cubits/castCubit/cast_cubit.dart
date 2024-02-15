import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movieModel/cast_model.dart';
import '../../services/cast_service.dart';
import 'cast_state.dart';

class CastCubit extends Cubit<CastState>{
  CastCubit(this.castService) : super(CastInitial());
  CastService castService;
  List<CastModel?>? cast;
  void getCast({required int id}) async{
    try{
      emit(CastLoading());
      cast = await castService.getCast(movieId: id);
      emit(CastSuccess(cast: cast!));
    }on Exception catch(e){
      emit(CastFailed(exp: '$e'));
    }
  }
}