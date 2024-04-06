
abstract class SearchMoviesState {}

class SearchMoviesInitial extends SearchMoviesState{}
class SearchMoviesLoading extends SearchMoviesState{
  final bool isLoading;
  final List? movies;
  SearchMoviesLoading({this.movies, required this.isLoading});
}
class SearchMoviesLoadingMore extends SearchMoviesState{
  final List moreMovies;
  final bool hasNextPage;
  SearchMoviesLoadingMore({required this.moreMovies, required this.hasNextPage});
}
// class LoadFirstPage extends SearchMoviesState{
//   final List movies;
//   LoadFirstPage({required this.movies});
// }
class SearchMoviesSuccess extends SearchMoviesState{
  final List movies;
  SearchMoviesSuccess({required this.movies});
}
class SearchMoviesFailed extends SearchMoviesState{
  final String exp;
  SearchMoviesFailed({required this.exp});
}