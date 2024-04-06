import 'package:movies/domain/model/movieModel/movie_model.dart';

abstract class MoviesRepo{
  Future<List<MovieModel?>> getMoviesFromRemote({required int page, String? moviesType, String? movieTitle, int? genre});
}