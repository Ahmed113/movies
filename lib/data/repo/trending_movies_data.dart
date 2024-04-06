import '../../domain/model/movieModel/movie_model.dart';
import '../../domain/model/repo/movies_repo.dart';
import '../../presentation/utils/constants.dart';
import '../remote/movies_api_service.dart';

class TrendingMoviesData implements MoviesRepo{
  TrendingMoviesData(this.moviesApiService);
  MoviesApiService moviesApiService;

  @override
  Future<List<MovieModel?>> getMoviesFromRemote({required int page, String? moviesType, String? movieTitle, int? genre}) {
    Uri url = Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: '3/movie/popular',
        queryParameters: {
          'api_key': API_KEY,
          'include_adult': 'false',
          'page': '$page',
          // 'sort_by': 'popularity.desc',
          // 'with_release_type': '2|3',
          // 'release_date.gte': '{min_date}',
          // 'release_date.lte': '{max_date}'
        }
    );
    return moviesApiService.getMovies(page: page, url: url);
  }

  // @override
  // Future<List<MovieModel?>> getMoviesFromRemote({required int page, String? moviesType, int? genre}) {
  //   return moviesApiService.getMovies(page: page, moviesType: 'popular');
  // }

  // @override
  // Future<List<MovieModel?>> getMoviesFromRemote(int page, String moviesType) {
  //   return moviesApiService.getMovies(page: page, moviesType: 'popular');
  // }
}