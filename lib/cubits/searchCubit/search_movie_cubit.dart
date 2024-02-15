import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/cubits/searchCubit/search_movieState.dart';
import 'package:movies/fetchMovieData/movies_search_data.dart';
import 'package:movies/movieModel/movie_model.dart';

class SearchMoviesCubit extends Cubit<SearchMoviesState> {
  SearchMoviesCubit(this.moviesData) : super(SearchMoviesInitial());
  MoviesSearchData moviesData;
  int page = 1;
  int currentPage = 0;
  bool isLoading = false;
  bool hasNextPage = true;
  List<MovieModel?> movies = List.empty(growable: true);
  List<MovieModel?> allFetchedMovies = List.empty(growable: true);

  void getMovies({required String title}) async {
    try {
      if (page == 1 && title.isNotEmpty) {
        emit(SearchMoviesLoading(
          isLoading: true,
        ));
      } else {
        emit(SearchMoviesInitial());
      }
      while (hasNextPage == true) {
        movies = await moviesData.searchMovies(movieTitle: title, page: page);
        currentPage = page;
        if (movies.isNotEmpty) {
          allFetchedMovies.addAll(movies);
          page++;
          print("ppppppppppp$page");
          emit(SearchMoviesLoadingMore(
              moreMovies: List.from(allFetchedMovies), hasNextPage: true));
        } else {
          hasNextPage = false;
          // emit(SearchMoviesLoadingMore(moreMovies: List.from(allFetchedMovies), hasNextPage: false));
        }
      }
    } on Exception catch (e) {
      emit(SearchMoviesFailed(exp: '$e'));
      isLoading = false;
    }
  }

  void disposePreviousSearch() {
    page = 1;
    movies.clear();
    allFetchedMovies.clear();
    isLoading = false;
    hasNextPage = true;
  }
}

//{
//     try{
//       // emit(SearchMoviesLoading());
//
//       List<MovieModel?> movies = [];
//       List<MovieModel?> allMovies = [];
//         if (isLoading) return;
//         isLoading = true;
//
//         emit(SearchMoviesLoading(movies: List.from(movies)));
//         if (page == 1) {
//           emit(SearchMoviesLoading(movies: []));
//         }
//         // else{
//         //
//         //   emit(SearchMoviesLoadingMore(movies: List.from(movies)));
//         // }
//         // emit(SearchMoviesLoadingMore(movies: List.from(movies)));
//         movies = await moviesData.searchMovies(movieTitle: title, page: page);
//         print('mmmmmmmm$movies');
//         if (movies.isEmpty) {
//           isLoading = false;
//           return;
//         }else
//         // allMovies.addAll(movies);
//       {final existingMovies = (state as SearchMoviesLoading).movies;
//         emit(SearchMoviesSuccess(movies: List.from(existingMovies)..addAll(movies)));
//         page++;}
//         isLoading = false;
//
//       // emit(SearchMoviesSuccess(movies: allMovies));
//       // isLoading = false;
//     }on Exception catch(e){
//       emit(SearchMoviesFailed(exp:'$e'));
//       isLoading = false;
//     }
//   }
