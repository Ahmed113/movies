abstract class GenreState {}

class GenreStateInitial extends GenreState {}

class GenreStateLoading extends GenreState {
  GenreStateLoading({required this.isLoading});

  final bool isLoading;
}

class GenreStateLoadingSuccess extends GenreState {
  final List genreMovies;
  final bool hasNextLoading;

  GenreStateLoadingSuccess(
      {required this.genreMovies, required this.hasNextLoading});
}

class GenreStateLoadingFailed extends GenreState {
  final String exp;

  GenreStateLoadingFailed({required this.exp});
}
