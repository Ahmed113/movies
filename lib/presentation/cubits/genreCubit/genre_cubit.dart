import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/model/repo/movies_repo.dart';

import '../../../domain/model/movieModel/movie_model.dart';
import 'genre_state.dart';


class GenreCubit extends Cubit<GenreState> {
  GenreCubit(this.moviesRepo) : super(GenreStateInitial());

  MoviesRepo moviesRepo;
  List<MovieModel?> genreMovies = List.empty(growable: true);
  List<MovieModel?> allGenreMovies = List.empty(growable: true);
  int genreMoviesPage = 1;
  bool hasNextGenreMoviesPage = true;

  void loadGenreMovies(String genre, bool loadMore) async {
    try {
      if (genreMoviesPage == 1) {
        emit(GenreStateLoading(isLoading: true));
      }
      if (loadMore == true) {
        if (hasNextGenreMoviesPage = true) {
          switch (genre) {
            case 'Action':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 28);
              break;
            case 'Adventure':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 12);
              break;
            case 'Animation':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 16);
              break;
            case 'Comedy':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 35);
              break;
            case 'Crime':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 80);
              break;
            case 'Documentary':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 99);
              break;
            case 'Drama':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 18);
              break;
            case 'Family':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 10751);
              break;
            case 'Fantasy':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 14);
              break;
            case 'History':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 36);
              break;
            case 'Horror':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 27);
              break;
            case 'Music':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 10402);
              break;
            case 'Mystery':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 9648);
              break;
            case 'Romance':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 10749);
              break;
            case 'Science Fiction':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 878);
              break;
            case 'TV Movie':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 10770);
              break;
            case 'Thriller':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 53);
              break;
            case 'War':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 10752);
              break;
            case 'Western':
              genreMovies = await moviesRepo.getMoviesFromRemote(
                  page: genreMoviesPage, genre: 37);
              break;
          }
          if (genreMovies.isNotEmpty) {
            allGenreMovies.addAll(genreMovies);
            emit(GenreStateLoadingSuccess(
                genreMovies: List.from(allGenreMovies), hasNextLoading: true));
            genreMoviesPage++;
          } else {
            hasNextGenreMoviesPage = false;
            genreMovies.clear();
            allGenreMovies.clear();
            genreMoviesPage = 1;
          }
        }
      }
    } on Exception catch (e) {
      emit(GenreStateLoadingFailed(exp: '$e'));
    }
  }

  void disposePreviousGenreMovies() {
    genreMoviesPage = 1;
    genreMovies.clear();
    allGenreMovies.clear();
    // isLoading = false;
    hasNextGenreMoviesPage = true;
  }
}
