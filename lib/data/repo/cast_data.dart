import 'package:movies/data/remote/cast_service.dart';
import 'package:movies/domain/model/movieModel/cast_model.dart';
import 'package:movies/domain/model/repo/cast_repo.dart';


class CastData implements CastRepo{
  CastData(this.castService);
  CastService castService;

  @override
  Future<List<CastModel?>?> getCast({required int movieId}) {
    return castService.getCast(movieId: movieId);
  }

}