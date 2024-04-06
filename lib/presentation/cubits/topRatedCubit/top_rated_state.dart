abstract class TopRatedState {}

class TopRatedInitial extends TopRatedState {}

class TopRatedLoading extends TopRatedState {}

class TopRatedLoadingMore extends TopRatedState {
  final List topRatedMovies;

  TopRatedLoadingMore({required this.topRatedMovies});
}

class TopRatedSuccess extends TopRatedState {
  final List topRatedMovies;

  TopRatedSuccess({required this.topRatedMovies});
}

class TopRatedFailed extends TopRatedState {
  final String exp;

  TopRatedFailed({required this.exp});
}
