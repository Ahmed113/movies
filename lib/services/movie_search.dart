import 'dart:async';
import 'package:movies/utils/constants.dart';

import '../movieModel/movie_model.dart';
import 'package:dio/dio.dart';


class MovieSearch{

  Future<List<MovieModel?>> searchMovies({required String movieTitle, required int page}) async{
      try{

        Uri url = Uri(
            scheme: 'https',
            host: 'api.themoviedb.org',
            path: '3/search/movie',
            queryParameters: {
              'api_key': API_KEY,
              'query': movieTitle,
              'include_adult': 'false',
              'page': '$page'
            }
        );
        print('uuuuuuuuuuu$url');
        print('eeeeeeeeeeeee$page');
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