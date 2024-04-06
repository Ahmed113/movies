import 'package:movies/data/repo/trending_movies_data.dart';
import '../../../../data/remote/movies_api_service.dart';
import '../../../../domain/model/movieModel/movie_model.dart';
import '../home_cubit.dart';

class TrendingCubit extends HomeMoviesCubit<MovieModel>{
  TrendingCubit():super(TrendingMoviesData(MoviesApiService()));

}