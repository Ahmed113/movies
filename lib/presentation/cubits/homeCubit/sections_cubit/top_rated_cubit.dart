import 'package:movies/data/remote/movies_api_service.dart';
import 'package:movies/data/repo/top_rated_movies_data.dart';
import 'package:movies/domain/model/movieModel/movie_model.dart';

import '../home_cubit.dart';

class TopRatedCubit extends HomeMoviesCubit<MovieModel>{
  TopRatedCubit():super(TopRatedMoviesData(MoviesApiService()));

}