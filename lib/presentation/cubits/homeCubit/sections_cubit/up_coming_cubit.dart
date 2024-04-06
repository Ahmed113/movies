import 'package:movies/data/remote/movies_api_service.dart';
import 'package:movies/data/repo/up_coming_movies_data.dart';
import 'package:movies/domain/model/movieModel/movie_model.dart';
import 'package:movies/presentation/cubits/homeCubit/home_cubit.dart';

class UpcomingCubit extends HomeMoviesCubit<MovieModel>{
  UpcomingCubit():super(UpcomingMoviesData(MoviesApiService()));
}