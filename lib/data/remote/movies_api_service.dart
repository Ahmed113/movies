import 'package:dio/dio.dart';

import '../../domain/model/movieModel/movie_model.dart';


class MoviesApiService{

  Future<List<MovieModel?>> getMovies({required int page, required Uri url}) async{

    try{
      // Uri url;
      // if (genre==null) {
      //   url = Uri(
      //       scheme: 'https',
      //       host: 'api.themoviedb.org',
      //       path: '3/movie/$moviesType',
      //       queryParameters: {
      //         'api_key': API_KEY,
      //         'include_adult': 'false',
      //         'page': '$page',
      //         // 'sort_by': 'popularity.desc',
      //         // 'with_release_type': '2|3',
      //         // 'release_date.gte': '{min_date}',
      //         // 'release_date.lte': '{max_date}'
      //       }
      //   );
      // }  else{
      //   url = Uri(
      //       scheme: 'https',
      //       host: 'api.themoviedb.org',
      //       path: '3/discover/movie',
      //       queryParameters: {
      //         'api_key': API_KEY,
      //         'include_adult': 'false',
      //         'page': '$page',
      //         'with_genres': '$genre'
      //       }
      //   );
      // }

      print('pppppppppppppppppp$url');
      final response = await Dio().get(url.toString());
      if (response.statusCode == 200) {
        if (response.data['results'] != null) {
          List<MovieModel> movies = [];
          print('tttttttttttttttttt$movies');
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