import 'package:movies/services/movie_search.dart';

import '../movieModel/movie_model.dart';

class MoviesSearchData{
  final MovieSearch movieSearch;
  MoviesSearchData(this.movieSearch);
  Future<List<MovieModel?>> searchMovies({required String movieTitle, required int page}){
    return movieSearch.searchMovies(movieTitle: movieTitle, page: page);
  }
}