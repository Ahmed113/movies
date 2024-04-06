import '../movieModel/cast_model.dart';

abstract class CastRepo{
  Future<List<CastModel?>?> getCast({required int movieId});
}