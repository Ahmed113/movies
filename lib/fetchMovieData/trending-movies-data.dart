import '../movieModel/movie_model.dart';
import '../services/trending-movies.dart';

class TrendingMoviesData{
  final TrendingMoviesService trendingMovies;
  TrendingMoviesData(this.trendingMovies);
  Future<List<MovieModel?>> getTrendingMoviesData({required int page}) async {
    return await trendingMovies.getTrendingMovies( page: page);
  }
}