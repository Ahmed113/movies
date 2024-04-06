import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/model/repo/cast_repo.dart';
import '../../../domain/model/movieModel/cast_model.dart';
import 'cast_state.dart';

class CastCubit extends Cubit<CastState>{
  CastCubit(this.castRepo) : super(CastInitial());
  CastRepo castRepo;
  List<CastModel?>? cast;
  void getCast({required int id}) async{
    try{
      emit(CastLoading());
      cast = await castRepo.getCast(movieId: id);
      emit(CastSuccess(cast: cast!));
    }on Exception catch(e){
      emit(CastFailed(exp: '$e'));
    }
  }
}