import 'package:movies/services/now-playing-movies.dart';

import '../movieModel/movie_model.dart';

class NowPlayingMoviesData{
  final NowPlayingMoviesService nowPlayingMovies;
  NowPlayingMoviesData(this.nowPlayingMovies);
  Future<List<MovieModel?>> getNowPlayingMoviesData({required int page}) async {
    return await nowPlayingMovies.getNowPlayingMovies( page: page);
  }
}