import 'package:dio/dio.dart';
import 'package:movies/movieModel/cast_model.dart';
import 'package:movies/utils/constants.dart';

class CastService{


  Future<List<CastModel?>?> getCast({required int movieId}) async{
    try{
      Uri url = Uri(
          scheme: 'https',
          host: 'api.themoviedb.org',
          path: '3/movie/$movieId/credits',
          queryParameters: {
            'api_key': API_KEY,
          }
      );
      final response = await Dio().get(url.toString());
      if (response.data['cast'] != null) {
        List<CastModel> casts = [];
        response.data['cast'].forEach((value){
          casts.add(CastModel.fromjson(value));
        }
        );
        return casts;
      }
      return [];
    }catch(e){
      if(e is DioException){
        throw Exception('Internet Connection Failed');
      }else {
        throw Exception('Error: $e');
      }
    }
  }
}