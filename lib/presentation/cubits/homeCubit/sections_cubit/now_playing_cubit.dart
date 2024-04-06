import '../../../../data/remote/movies_api_service.dart';
import '../../../../data/repo/now_playing_movies_data.dart';
import '../../../../domain/model/movieModel/movie_model.dart';
import '../home_cubit.dart';

class NowPlayingCubit extends HomeMoviesCubit<MovieModel>{
  NowPlayingCubit():super(NowPlayingMoviesData(MoviesApiService()));

}