import 'package:dio/dio.dart';

import '../movieModel/movie_model.dart';
import '../utils/constants.dart';

class TopRatedMoviesService{
  String l = 'https://api.themoviedb.org/3/movie/top_rated?api_key=4647d525718d56223cef44d8254aa25b&page=1&include_adult=false';
  Future<List<MovieModel?>> getTopRatedMovies({required int page}) async{
    try{
      Uri url = Uri(
          scheme: 'https',
          host: 'api.themoviedb.org',
          path: '3/movie/top_rated',
          queryParameters: {
            'api_key': API_KEY,
            'include_adult': 'false',
            'page': '$page'
            // 'sort_by': 'vote_average.desc',
            // 'vote_count.gte': '200v',
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
          print('ddddddddddd$movies');
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