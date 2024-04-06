
import '../../../domain/model/movieModel/movie_model.dart';

abstract class HomeState {}

class HomeStateInitial extends HomeState {}

class HomeStateLoading extends HomeState {
  final bool isLoading;

  HomeStateLoading({required this.isLoading});
}

class HomeStateSuccess<T> extends HomeState {
  final List<T> movies;
  final bool hasNextLoading;

  HomeStateSuccess({required this.movies, required this.hasNextLoading});
}

class HomeStateFailed extends HomeState {
  final String exp;

  HomeStateFailed({required this.exp});
}

class HomeTopRatedState extends HomeStateSuccess<MovieModel> {
  HomeTopRatedState({required List<MovieModel> movies, required bool hasNextLoading})
      : super(movies: movies, hasNextLoading: hasNextLoading);
}

class HomeTrendingState extends HomeStateSuccess<MovieModel> {
  HomeTrendingState({required List<MovieModel> movies, required bool hasNextLoading})
      : super(movies: movies, hasNextLoading: hasNextLoading);
}

class HomeNowPlayingState extends HomeStateSuccess<MovieModel> {
  HomeNowPlayingState({required List<MovieModel> movies, required bool hasNextLoading})
      : super(movies: movies, hasNextLoading: hasNextLoading);
}

class HomeUpComingState extends HomeStateSuccess<MovieModel> {
  HomeUpComingState({required List<MovieModel> movies, required bool hasNextLoading})
      : super(movies: movies, hasNextLoading: hasNextLoading);
}

