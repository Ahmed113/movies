import 'package:movies/services/top-rated-movies.dart';

import '../movieModel/movie_model.dart';

class TopRatedMoviesData{
  final TopRatedMoviesService topRatedMovies;
  TopRatedMoviesData(this.topRatedMovies);
  Future<List<MovieModel?>> getTopRatedMoviesData({required int page}) async {
    return await topRatedMovies.getTopRatedMovies( page: page);
  }
}