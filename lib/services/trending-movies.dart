import 'package:dio/dio.dart';

import '../movieModel/movie_model.dart';
import '../utils/constants.dart';

class TrendingMoviesService{
  // String l = 'https://api.themoviedb.org/3/discover/movie?'
  //     'include_adult=false&include_video=false&language=en-US&'
  //     'page=1&sort_by=popularity.desc&with_release_type=2|3&'
  //     'release_date.gte={min_date}&release_date.lte={max_date}';
  Future<List<MovieModel?>> getTrendingMovies({required int page}) async{
    try{
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
      print('uuuuuuuuuuu$url');
      final response = await Dio().get(url.toString());
      if (response.statusCode == 200) {
        if (response.data['results'] != null) {
          List<MovieModel> movies = [];
          response.data['results'].forEach((value){
            movies.add(MovieModel.fromjson(value));
          }
          );
          return movies;
        }else{
          throw Exception(response.statusMessage);
        }
      }
      return [];
    }catch(e){
      if(e is DioException){
        throw Exception('Internet Connection Failed');
      }
      else {
        throw Exception('$e');
      }
    }
  }
}