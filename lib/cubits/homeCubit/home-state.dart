import 'package:movies/movieModel/movie_model.dart';

// abstract class HomeState {}
abstract class HomeTopRatedState {}
abstract class HomeTrendingState {}
abstract class HomeNowPlayingState {}

class HomeTopRatedStateInitial extends HomeTopRatedState {}
class HomeTrendingStateInitial extends HomeTrendingState {}
class HomeNowPlayingStateInitial extends HomeNowPlayingState {}

// class HomeStateFirstLoading extends HomeState {
//   final List<MovieModel>? topRatedMovies;
//   final List<MovieModel>? trendingMovies;
//   final List<MovieModel>? newPlayingMovies;
//   final bool isTopRatedLoading;
//   final bool isTrendingLoading;
//   final bool isNowPlayingLoading;
//   //
//   HomeStateFirstLoading({
//     this.topRatedMovies,
//     this.trendingMovies,
//     this.newPlayingMovies,
//     required this.isTopRatedLoading,
//     required this.isTrendingLoading,
//     required this.isNowPlayingLoading
//   });
// }

// class HomeStateLoading extends HomeState {
//   final List<MovieModel> topRatedMovies;
//   final List<MovieModel> trendingMovies;
//   final List<MovieModel> newPlayingMovies;
//   final bool isTopRatedLoading;
//   final bool isTrendingLoading;
//   final bool isNowPlayingLoading;
//   //
//   HomeStateLoading({
//     required this.topRatedMovies,
//     required this.trendingMovies,
//     required this.newPlayingMovies,
//     required this.isTopRatedLoading,
//     required this.isTrendingLoading,
//     required this.isNowPlayingLoading
//   });
// }

class HomeStateTopRatedLoading extends HomeTopRatedState {
  // final List<MovieModel>? topRatedMovies;
  // final List<MovieModel>? trendingMovies;
  // final List<MovieModel>? newPlayingMovies;
  final bool isLoading;
  //
  HomeStateTopRatedLoading({
    // this.topRatedMovies,
    // this.trendingMovies,
    // this.newPlayingMovies,
     required this.isLoading
  });
}

class HomeStateTrendingLoading extends HomeTrendingState {
  // final List<MovieModel>? topRatedMovies;
  // final List<MovieModel>? trendingMovies;
  // final List<MovieModel>? newPlayingMovies;
  final bool isLoading;
  //
  HomeStateTrendingLoading({
    // this.topRatedMovies,
    // this.trendingMovies,
    // this.newPlayingMovies,
     required this.isLoading
  });
}

class HomeStateNowPlayingLoading extends HomeNowPlayingState {
  // final List<MovieModel>? topRatedMovies;
  // final List<MovieModel>? trendingMovies;
  // final List<MovieModel>? newPlayingMovies;
  final bool isLoading;
  //
  HomeStateNowPlayingLoading({
    // this.topRatedMovies,
    // this.trendingMovies,
    // this.newPlayingMovies,
     required this.isLoading
  });
}

// class HomeStateLoadingMore extends HomeState {
//   final List<MovieModel?>? topRatedMovies;
//   final List<MovieModel?>? trendingMovies;
//   final List<MovieModel?>? nowPlayingMovies;
//   final bool hasNextLoading;
//
//   HomeStateLoadingMore({
//      this.topRatedMovies,
//      this.trendingMovies,
//      this.nowPlayingMovies,
//     required this.hasNextLoading
//   });
// }

// class HomeStateSuccess extends HomeState {
//   final List topRatedMovies;
//   final List trendingMovies;
//   final List nowPlayingMovies;
//   final bool hasNextLoading;
//
//   HomeStateSuccess({
//     required this.topRatedMovies,
//     required this.trendingMovies,
//     required this.nowPlayingMovies,
//     required this.hasNextLoading
//   });}

class HomeStateTopRatedSuccess extends HomeTopRatedState {
  final List topRatedMovies;
  // final List? trendingMovies;
  // final List? nowPlayingMovies;
  final bool hasNextLoading;

  HomeStateTopRatedSuccess({
    required this.topRatedMovies,
    // this.trendingMovies,
    // this.nowPlayingMovies,
    required this.hasNextLoading
  });
}class HomeStateTrendingSuccess extends HomeTrendingState {
  // final List? topRatedMovies;
  final List trendingMovies;
  // final List? nowPlayingMovies;
  final bool hasNextLoading;

  HomeStateTrendingSuccess({
    // this.topRatedMovies,
    required this.trendingMovies,
    // this.nowPlayingMovies,
    required this.hasNextLoading
  });
}
class HomeStateNowPlayingSuccess extends HomeNowPlayingState {
  // final List? topRatedMovies;
  // final List? trendingMovies;
  final List nowPlayingMovies;
  final bool hasNextLoading;

  HomeStateNowPlayingSuccess({
    // this.topRatedMovies,
    // this.trendingMovies,
    required this.nowPlayingMovies,
    required this.hasNextLoading
  });}

class HomeTopRatedStateFailed extends HomeTopRatedState {
  final String exp;

  HomeTopRatedStateFailed({required this.exp});
}
class HomeTrendingStateFailed extends HomeTrendingState {
  final String exp;

  HomeTrendingStateFailed({required this.exp});
}
class HomeNowPlayingStateFailed extends HomeNowPlayingState {
  final String exp;

  HomeNowPlayingStateFailed({required this.exp});
}
