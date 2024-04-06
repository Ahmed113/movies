import 'package:movies/data/remote/movies_api_service.dart';
import 'package:movies/domain/model/movieModel/movie_model.dart';
import 'package:movies/domain/model/repo/movies_repo.dart';

import '../../presentation/utils/constants.dart';

class GenreMoviesData implements MoviesRepo{
  GenreMoviesData(this.moviesApiService);
  MoviesApiService moviesApiService;

  @override
  Future<List<MovieModel?>> getMoviesFromRemote({required int page, String? moviesType, String? movieTitle, int? genre}) {
    Uri url = Uri(
            scheme: 'https',
            host: 'api.themoviedb.org',
            path: '3/discover/movie',
            queryParameters: {
              'api_key': API_KEY,
              'include_adult': 'false',
              'page': '$page',
              'with_genres': '$genre'
            }
        );
    return moviesApiService.getMovies(page: page, url: url);
  }

  // @override
  // Future<List<MovieModel?>> getMoviesFromRemote({required int page, String? moviesType, int? genre}) {
  //   return moviesApiService.getMovies(page: page, genre: genre!);
  // }

  // @override
  // Future<List<MovieModel?>> getMoviesFromRemote(int page, String moviesType) {
  //   return moviesApiService.getMovies(page: page, genre: );
  // }
}