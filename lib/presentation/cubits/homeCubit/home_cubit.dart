import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/model/repo/movies_repo.dart';
import 'package:movies/presentation/cubits/homeCubit/sections_cubit/now_playing_cubit.dart';
import 'package:movies/presentation/cubits/homeCubit/sections_cubit/top_rated_cubit.dart';
import 'package:movies/presentation/cubits/homeCubit/sections_cubit/trinding_cubit.dart';
import 'package:movies/presentation/cubits/homeCubit/sections_cubit/up_coming_cubit.dart';
import '../../../domain/model/movieModel/movie_model.dart';
import 'home_state.dart';

class HomeMoviesCubit<T> extends Cubit<HomeState>{
  HomeMoviesCubit(this.moviesRepo)
      : super(HomeStateInitial());

  MoviesRepo moviesRepo;
  List<MovieModel?> movies = List.empty(growable: true);
  List<MovieModel?> allMovies = List.empty(growable: true);
  int page = 1;
  bool hasNextPage = true;



  void loadMovies(bool loadMore) async {
    try {
      if (page == 1) {
        emit(HomeStateLoading(
          // topRatedMovies: List.from(allTopRatedMovies),
            isLoading: true));
      }
      if (loadMore == true) {
        if (hasNextPage == true) {
          movies = await moviesRepo.getMoviesFromRemote(page: page);
          if (movies.isNotEmpty) {
            allMovies.addAll(movies);
            emit(_getSpecificState(
                movies: List.from(allMovies),
                hasNextLoading: true));
            page++;
          } else {
            hasNextPage = false;
          }
        }
      } else {
        while (hasNextPage == true && allMovies.length <= 10) {
          movies = await moviesRepo.getMoviesFromRemote(page: page);
          if (movies.isNotEmpty) {
            allMovies.addAll(movies);
            emit(_getSpecificState(
                movies: List.from(allMovies),
                hasNextLoading: true));
            page++;
          } else {
            hasNextPage = false;
          }
        }
      }
    } on Exception catch (e) {
      emit(HomeStateFailed(exp: '$e'));
    }
  }


  HomeState _getSpecificState({required List<MovieModel> movies, required bool hasNextLoading}) {
    if (T == MovieModel) {
      if (this is TopRatedCubit) {
        return HomeTopRatedState(movies: movies, hasNextLoading: hasNextLoading);
      } else if (this is TrendingCubit) {
        return HomeTrendingState(movies: movies, hasNextLoading: hasNextLoading);
      } else if (this is NowPlayingCubit) {
        return HomeNowPlayingState(movies: movies, hasNextLoading: hasNextLoading);
      } else if (this is UpcomingCubit) {
        return HomeUpComingState(movies: movies, hasNextLoading: hasNextLoading);
      }
    }
    throw Exception('Unsupported cubit or type');
  }
}